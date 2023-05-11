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
        let randomNum = (0...members.count).randomElement()!
        
        if randomNum == 0 {
            memberName = "모두"
        } else {
            memberName = members.randomElement()!.name
        }
        
//        // 한글 조사 입력
//        guard let text = memberName.last else { return memberName }
//
//        let val = UnicodeScalar(String(text))?.value
//        guard let value = val else { return memberName }
//        // 종성 인덱스 계산
//        let index = (value - 0xac00) % 28
//        // 조사 판별 후 리턴
//        if index == 0 {
//            return memberName + "가"
//        } else {
//            return memberName + "이"
//        }
        
        return memberName
        
    }
}
