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
        return memberName
    }
}
