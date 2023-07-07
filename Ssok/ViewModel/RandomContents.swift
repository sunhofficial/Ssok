//
//  RandomMember.swift
//  6Bubbles
//
//  Created by 김민 on 2023/05/08.
//

import SwiftUI

class RandomContents: ObservableObject {

    @Published var members: [Member] = []
    @Published var randomWho: String = ""
    @Published var randomWhere: String = ""
    @Published var randomWhat = Mission(
        missionType: .decibel,
        missionInfo: MissionInfo(
            missionTitle: "",
            missionTip: ""),
        missionDetail: [:])

    func setRandomMember(_ members: [Member]) -> String {
        var memberName: String = ""
        memberName = members.randomElement()!.name
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

    func setRandomContents() {
        randomWho = setRandomMember(members)
        randomWhat = missions.randomElement()!
        randomWhere = howList.randomElement()!
    }
}
