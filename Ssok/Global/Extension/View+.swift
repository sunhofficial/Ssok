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
    
//    func setRandomMember(_ members: [Member]) -> String {
//        var memberName: String = ""
//        let randomNum = (1...2).randomElement()!
//
//        if randomNum == 1 {
//            memberName = members.randomElement()!.name
//        } else {
//            memberName = "모두"
//        }
//        return memberName
//    }
}
