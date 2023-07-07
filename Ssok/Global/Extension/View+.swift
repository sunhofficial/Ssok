//
//  ViewExtension.swift
//  6Bubbles
//
//  Created by 235 on 2023/05/06.
//

import SwiftUI

extension View {

    func endTextEditing() {
        UIApplication.shared.sendAction(
            #selector(UIResponder.resignFirstResponder),
            to: nil,
            from: nil,
            for: nil
        )
    }

    func setRandomMember(_ members: [Member]) -> String {
        var memberName: String = ""
        memberName = members.randomElement()!.name
        // 한글 조사 입력
        guard let text = memberName.last else { return memberName }
        let value = UnicodeScalar(String(text))?.value
        guard let value = value else { return memberName }
        let index = (value - 0xac00) % 28
        if index == 0 {
            return memberName + "가"
        } else {
            return memberName + "이"
        }
    }

    func setRandomMission(_ missions: [Mission]) -> Mission {
        return missions.randomElement()!
    }

    func setRandomWhere(_ places: [String]) -> String {
        return places.randomElement()!
    }

    func getSafeArea() -> UIEdgeInsets {
        return UIApplication.shared.windows.first?.safeAreaInsets ??
        UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }

}
