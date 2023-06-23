//
//  RandomMember.swift
//  6Bubbles
//
//  Created by 김민 on 2023/05/08.
//

import SwiftUI

class RandomMember: ObservableObject {

    @Published var members: [Member] = []
    @Published var randomWho: String = ""
    @Published var randomWhere: String = ""
//    @Published var randomWhat: Mission = Mission(
//        missionType: .blink,
//        missionTitle: "",
//        missionTip: "",
//        missionColor: .black)
    @Published var randomWhat = Mission(
        missionType: .decibel,
        missionDetail: MissionDetail(
            missionTitle: "",
            missionTip: "",
            missionColor: .black),
        detail: [:])
}
