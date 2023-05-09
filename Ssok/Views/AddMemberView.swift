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
    
    @State private var memberName: String = ""
    @State private var isAlertShowing = false
    @State private var keyboardHeight: CGFloat = 0
    @State private var isTextFieldEmtpy = true
    @State private var members: [Member] = []
    @FocusState private var isFocused: Bool
    @EnvironmentObject var randomMember: RandomMember
    
    var body: some View {
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
                        .accentColor(.orange)
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
                    } message: {
                        Text("팀원 선택은 최대 6명까지만\n선택 가능합니다")
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
                
                NavigationLink(destination: StrawView()) {
                    Text("다음")
                        .foregroundColor(.white)
                        .fontWeight(.medium)
                        .frame(maxWidth: 350, maxHeight: 50, alignment: .center)
                        .background(Color.orange)
                        .cornerRadius(12)
                }
                .simultaneousGesture(TapGesture().onEnded {
//                    randomMember.randomMemberNames = setRandomMembers(members)
                    randomMember.randomMemberName = setRandomMember(members)
                })
            }
            .navigationTitle("게임 인원")
            .navigationBarTitleDisplayMode(.large)
            .navigationBarBackButtonHidden()
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                EditButton()
                    .foregroundColor(.orange)
            }
        }
        .onAppear {
            setMemberData()
        }
        .onDisappear {
            NotificationCenter.default.removeObserver(self)
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
    
    //    private func setRandomMember(_ members: [Member]) -> [String] {
    //        var randomMember: [String] = []
    //        let memberNum = (1...members.count).randomElement()!
    //
    //        while randomMember.count < memberNum {
    //            let member = members.randomElement()!
    //
    //            if !randomMember.contains(member.name) { randomMember.append(member.name) }
    //        }
    //
    //        return randomMember
    //    }
    //}
    
    private func setRandomNumber(_ members: [Member]) -> String {
        let random = (1...2).randomElement()!
        var member: String = ""
        
        if random == 1 {
            member = members.randomElement()!.name
        } else { member = "모두" }
        
        return member
    }
    
    private func setRandomMember(_ members: [Member]) -> String {
        var randomMember: String = ""
        let randomNum = (1...2).randomElement()!
        
        if randomNum == 1 {
            randomMember = members.randomElement()!.name
        } else {
            randomMember = "모두"
        }
        
        return randomMember
    }
}

struct AddMemberView_Previews: PreviewProvider {
    static var previews: some View {
        AddMemberView()
    }
}
