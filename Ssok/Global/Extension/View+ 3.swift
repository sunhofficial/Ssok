//
//  ViewExtension.swift
//  6Bubbles
//
//  Created by 235 on 2023/05/06.
//

import SwiftUI

extension View {
    
    func endTextEditing() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    func setRandomMember(_ members: [Member]) -> String {
        var memberName: String = ""
        memberName = members.randomElement()!.name
        
        // 영어 이름 바꾸기
        if let name = whoList[memberName] {
            memberName = name
        }
        
        // 한글 조사 입력
        guard let text = memberName.last else { return memberName }
        
        let val = UnicodeScalar(String(text))?.value
        guard let value = val else { return memberName }
        
        let index = (value - 0xac00) % 28
        if index == 0 {
            return memberName + "가"
        } else {
            return memberName + "이"
        }
    }
}
