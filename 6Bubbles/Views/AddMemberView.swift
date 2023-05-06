// AddMemberView
// 004


import Foundation
//
//  ContentView.swift
//  Soda
//
//  Created by 김민 on 2023/05/03.
//

import SwiftUI

struct AddMemberView: View {
    
    // MARK: - Properties
    
    @State private var memberName: String = ""
    @State private var isAlertShowing = false
    @State private var keyboardHeight: CGFloat = 0
    @State private var isTextFieldEmtpy = true
    @State var members: [Member] = []
    @FocusState private var isFocused: Bool
    
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                VStack {
                    // 추가 textField
                    HStack {
                        TextField("게임 인원을 입력해 주세요", text: $memberName)
                            .focused($isFocused)
                            .padding(.leading, 10)
                            .frame(height: 40)
                            .overlay {
                                RoundedRectangle(cornerSize: CGSize(width: 5, height: 5))
                                    .stroke(lineWidth: 1)
                                    .stroke(Color(.systemGray6))
                            }
                            .onSubmit {
                                if memberName == "" {
                                    isTextFieldEmtpy = true
                                } else {
                                    isTextFieldEmtpy = false
                                    plusButtonDidTap()
                                }
                            }
                            .onChange(of: memberName) { newValue in
                                if newValue == "" {
                                    isTextFieldEmtpy = true
                                } else {
                                    isTextFieldEmtpy = false
                                }
                            }
                            .padding(.leading, 15)
                        Button {
                            plusButtonDidTap()
                        } label: {
                            if isTextFieldEmtpy {
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
                        .disabled(isTextFieldEmtpy)
                        .alert("인원은 최대 6명까지 가능합니다.", isPresented: $isAlertShowing) {
                            Button("OK") {
                                isAlertShowing = false
                                isFocused = false
                            }
                        }
                    }
                    .padding(.top, 7)
                    .padding(.bottom, 5)
                    
                    // List
                    List {
                        Section {
                            ForEach(members) { member in
                                HStack {
                                    Text("🧋")
                                    Text(member.name)
                                }
                            }
                            .onDelete(perform: removeMembers)
                        } footer: {
                            Text("인원은 최대 6명까지 가능합니다.")
                                .font(.system(size: 13))
                                .foregroundColor(Color(.darkGray))
                        }

                    }
                    .frame(height: 400)
                    .listStyle(.inset)
                    .scrollDisabled(true)
                    
                    Spacer()

                    NavigationLink(destination: StrawView()){
                        EmptyView()
                    }
                }
            }
            .navigationTitle("게임 인원")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                        .foregroundColor(.orange)
                }
            }
            .onAppear {
                setMemberData()
//                disableKeyboardAvoidance()
            }
            .onDisappear {
                NotificationCenter.default.removeObserver(self)
            }
        }
        .onTapGesture {
            endTextEditing()
        }
    }
}

extension AddMemberView {
    
    // MARK: - Custom Methods
    
    private func setMemberData() {
        if let data = UserDefaults.standard.value(forKey: "members") as? Data {
            let decodedData = try? PropertyListDecoder().decode(Array<Member>.self, from: data)
            members = decodedData ?? []
        }
    }
    
//    private func disableKeyboardAvoidance() {
//        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main) { notification in
//            let value = notification.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! CGRect
//            keyboardHeight = value.height
//        }
//        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main) { notification in
//            keyboardHeight = 0
//        }
//    }
    
    private func appendMembers(_ memberName: String) {
        members.append(Member(name: memberName))
        UserDefaults.standard.set(try? PropertyListEncoder().encode(members), forKey: "members")
    }
    
    private func removeMembers(at offsets: IndexSet) {
        members.remove(atOffsets: offsets)
        UserDefaults.standard.set(try? PropertyListEncoder().encode(members), forKey: "members")
    }
    
    private func plusButtonDidTap() {
        if members.count >= 6 {
            isAlertShowing = true
            isFocused = false
        } else {
            appendMembers(memberName)
            isFocused = true
        }
        memberName = ""
    }
}

struct AddMemberView_Previews: PreviewProvider {
    static var previews: some View {
        AddMemberView()
    }
}
