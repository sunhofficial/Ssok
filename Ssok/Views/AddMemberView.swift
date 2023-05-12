//
//  ContentView.swift
//  Soda
//
//  Created by 김민 on 2023/05/03.
//
// AddMemberView
// 004

import SwiftUI

struct AddMemberView: View {
    
    // MARK: - Properties
    
    @StateObject private var viewModel  = AddMemberViewModel()
    
    @FocusState private var isFocused: Bool
    
    @EnvironmentObject var random: RandomMember
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                // 추가 textField
                HStack {
                    TextField("닉네임을 입력해주세요.", text: $viewModel.memberName)
                        .focused($isFocused)
                        .padding(.leading, 10)
                        .frame(height: 40)
                        .overlay {
                            RoundedRectangle(cornerSize: CGSize(width: 5, height: 5))
                                .stroke(lineWidth: 0.5)
                                .stroke(Color(.systemGray6))
                        }
                        .accentColor(.orange)
                        .onSubmit {
                            if viewModel.memberName == "" {
                                viewModel.isTextFieldEmtpy = true
                            } else {
                                viewModel.isTextFieldEmtpy = false
                                viewModel.plusButtonDidTap()
                            }
                        }
                        .onChange(of: viewModel.memberName) { newValue in
                            if newValue == "" {
                                viewModel.isTextFieldEmtpy = true
                            } else {
                                viewModel.isTextFieldEmtpy = false
                            }
                            viewModel.filterData()
                        }
                        .padding(.leading, 15)
                    Button {
                        viewModel.plusButtonDidTap()
                    } label: {
                        if viewModel.isTextFieldEmtpy {
                            Image(systemName: "plus.circle.fill")
                                .imageScale(.large)
                                .foregroundColor(Color(.systemGray5))
                        } else {
                            Image(systemName: "plus.circle.fill")
                                .imageScale(.large)
                                .foregroundColor(.orange)
                            
                        }
                    }
                    .padding(.trailing, 15)
                    .disabled(viewModel.isTextFieldEmtpy)
                    .alert("인원은 최대 6명까지 가능합니다.", isPresented: $viewModel.isAlertShowing) {
                        Button("OK") {
                            viewModel.isAlertShowing = false
                            isFocused = false
                        }
                    } message: {
                        Text("팀원 선택은 최대 6명까지만\n선택 가능합니다")
                    }
                }
                .padding(.top, 7)
                
                List {
                    Section {
                        if $viewModel.filteredData.isEmpty {
                            Text("추천 아카데미 러너가 없습니다.")
                                .font(.system(size: 14))
                                .foregroundColor(Color(.lightGray))
                        } else {
                            ForEach(viewModel.filteredData.prefix($viewModel.members.isEmpty ? 5 : 3), id: \.self) { data in
                                Button(action: {
                                    viewModel.memberName = data
                                    viewModel.plusButtonDidTap()
                                }) {
                                    Text(data)
                                }
                            }
                        }
                    } header: {
                        Text("아카데미 러너")
                            .font(.system(size: 13))
                            .foregroundColor(Color(.darkGray))
                    }
                    if !$viewModel.members.isEmpty {
                        Section {
                            ForEach(viewModel.members) { member in
                                HStack {
                                    Text("🧋")
                                    Text(member.name)
                                }
                            }
                            .onDelete(perform: viewModel.removeMembers)
                        } header: {
                            Text("같이 할 사람들")
                                .font(.system(size: 13))
                                .foregroundColor(Color(.darkGray))
                        } footer: {
                            Text("인원은 최대 6명까지 가능합니다.")
                                .font(.system(size: 13))
                                .foregroundColor(Color(.darkGray))
                        }
                    }
                }
                .listStyle(.inset)
                .scrollDisabled(true)
                
                Spacer()
                
                NavigationLink(destination: StrawView()) {
                    Text("다음")
                        .foregroundColor(.white)
                        .fontWeight(.medium)
                        .frame(maxWidth: 350, maxHeight: 50, alignment: .center)
                        .background(Color("Bg_bottom2"))
                        .cornerRadius(12)
                }
                .simultaneousGesture(TapGesture().onEnded {
                    random.members = viewModel.members
                    random.randomMemberName = setRandomMember(viewModel.members)
                })
                .disabled(viewModel.isNextButtonDisabled)
            }
            .navigationTitle("같이 할 사람들")
            .navigationBarTitleDisplayMode(.large)
            .navigationBarBackButtonHidden()
            .ignoresSafeArea(.keyboard)
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                EditButton()
                    .foregroundColor(Color("Bg_bottom2"))
            }
        }
        .onAppear {
            viewModel.setMemberData()
            viewModel.setNextButtonState()
        }
        .onDisappear {
            NotificationCenter.default.removeObserver(self)
        }
    }
}
