//
//  What.swift
//  6Bubbles
//
//  Created by 235 on 2023/05/06.
//

import Foundation
import SwiftUI

enum MissionType {
    case decibel, shake, voice, face
}

struct Mission {
    var missionType: MissionType
    var title: String
    var description: String
    var mainColor: Color
    var goal: String?
    var timer: Double?
    var smileRight: Float?
    var smileLeft: Float?
    var blinkRight: Float?
    var blinkLeft: Float?
}

let missions = [
    Mission(missionType: .decibel, title: "소리 지르기 💥", description: "장소로 이동해서 미션하기 버튼을 누르고\n소리를 질러 목표 데시벨을 채우세요", mainColor: Color("MissionDecibel"), goal: "30"),
    Mission(missionType: .decibel, title: "콧바람 장풍 불기 💨", description: "장소로 이동해서 미션하기 버튼을 누르고\n콧바람을 불어서 목표 데시벨을 채우세요", mainColor: Color("MissionDecibel"), goal: "30"),
    Mission(missionType: .decibel, title: "크게 노래 부르기 🎵", description: "장소로 이동해서 미션하기 버튼을 누르고\n콧바람을 불어서 목표 데시벨을 채우세요", mainColor: Color("MissionDecibel"), goal: "30"),
//    Mission(missionType: .shake, title: "춤추기 💃🏻", description: "장소로 이동해서 미션하기 버튼을 누르고\n자신있는 춤을 열심히 춰서 진동 횟수를 채워요!", mainColor: Color("MissionShake"), goal: "100"),
//    Mission(missionType: .shake, title: "혀 놀리기 👅", description: "장소로 이동해서 미션하기 버튼을 누르고\n주어진 문장을 읽을 준비 후 말하기 버튼을 눌러\n시간 안에 크고 정확하게 따라 읽어요!", mainColor: .blue, goal: "간장공장공장장", timer: 5.0),
//    Mission(missionType: .voice, title: "혀 놀리기 👅", description: "장소로 이동해서 미션하기 버튼을 누르고\n주어진 문장을 읽을 준비 후 말하기 버튼을 눌러\n시간 안에 크고 정확하게 따라 읽어요!", mainColor: Color("MissionVoice"), goal: "들의 콩깍지는 깐 콩깍지인가 안 깐 콩깍지인가", timer: 10.0),
//    Mission(missionType: .voice, title: "영국 신사 되기 💂🏻‍♀️", description: "장소로 이동해서 미션하기 버튼을 누르고\n주어진 문장을 읽을 준비 후 말하기 버튼을 눌러\n영국 발음으로 읽어야만 성공할 수 있어요!", mainColor: Color("MissionVoice"), goal: "Could I have a bottle of water please?", timer: 10.0),
//    Mission(missionType: .voice, title: "바보 되기 🤪", description: "장소로 이동해서 미션하기 버튼을 누르고\n나는 바보다라고 말할 준비가 되면\n말하기 버튼을 누르고 크게 외쳐주세요!", mainColor: Color("MissionVoice"), goal: "나는 바보다", timer: 5.0)
]
