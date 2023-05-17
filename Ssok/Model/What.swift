//
//  What.swift
//  6Bubbles
//
//  Created by 235 on 2023/05/06.
//

import Foundation
import SwiftUI

enum MissionType {
    case decibel, shake, voice, smile, blink
}

struct Mission {
    var missionType: MissionType
    var missionTitle: String
    var missionTip: String
    var missionColor: Color
    var goal: String?
    var timer: Double?
    var arstate: String?
}

let missions = [
//    Mission(missionType: .decibel, missionTitle: "소리 지르기 💥", missionTip: "장소로 이동해서 미션하기 버튼을 누르고\n소리를 질러 목표 데시벨을 채우세요.", missionColor: Color("MissionDecibel"), goal: "60"),
//    Mission(missionType: .decibel, missionTitle: "콧바람 장풍 불기 💨", missionTip: "장소로 이동해서 미션하기 버튼을 누르고\n콧바람을 불어서 목표 데시벨을 채우세요.", missionColor: Color("MissionDecibel"), goal: "50"),
//    Mission(missionType: .decibel, missionTitle: "크게 노래 부르기 🎵", missionTip: "장소로 이동해서 미션하기 버튼을 누르고\n자신있는 노래를 크게 불러 목표 데시벨을 채우세요.", missionColor: Color("MissionDecibel"), goal: "50"),
//    Mission(missionType: .shake, missionTitle: "춤추기 💃🏻", missionTip: "장소로 이동해서 미션하기 버튼을 누르고\n자신있는 춤을 열심히 춰서 진동 횟수를 채워요!", missionColor: Color("MissionShake"), goal: "40.0"),
//    Mission(missionType: .shake, missionTitle: "손 흔들기 👋🏻", missionTip: "장소로 이동해서 미션하기 버튼을 누르고\n주변 사람들에게 손을 흔들어 인사해요!", missionColor: Color("MissionShake"), goal: "10.0"),
//    Mission(missionType: .voice, missionTitle: "혀 놀리기 👅", missionTip: "장소로 이동해서 미션하기 버튼을 누르고\n주어진 문장을 읽을 준비 후 말하기 버튼을 눌러\n시간 안에 크고 정확하게 따라 읽어요!", missionColor: Color("MissionVoice"), goal: "들의 콩깍지는 깐 콩깍지인가 안 깐 콩깍지인가", timer: 10.0),
//    Mission(missionType: .voice, missionTitle: "영국 신사 되기 💂🏻‍♀️", missionTip: "장소로 이동해서 미션하기 버튼을 누르고\n주어진 문장을 읽을 준비 후 말하기 버튼을 눌러\n영국 발음으로 읽어야만 성공할 수 있어요!", missionColor: Color("MissionVoice"), goal: "Could I have a bottle of water please", timer: 10.0),
//    Mission(missionType: .voice, missionTitle: "바보 되기 🤪", missionTip: "장소로 이동해서 미션하기 버튼을 누르고\n나는 바보다라고 말할 준비가 되면\n말하기 버튼을 누르고 크게 외쳐주세요!", missionColor: Color("MissionVoice"), goal: "나는 바보다", timer: 5.0),
    Mission(missionType: .blink, missionTitle: "플러팅하기 😘", missionTip: "장소로 이동해서 미션하기 버튼을 누르고\n얼굴을 인식시켜 미션 완료까지 두 눈을 윙크하세요!", missionColor: .mint, arstate: "blink"),
//    Mission(missionType: .smile, missionTitle: "팀원웃기기 😄", missionTip: "장소로 이동해서 미션하기 버튼을 누르고\n얼굴을 인식시켜 미션 완료까지 웃으세요!", missionColor: .mint, arstate: "smile")
    Mission(missionType: .smile, missionTitle: "혀내밀기 😄", missionTip: "장소로 이동해서 미션하기 버튼을 누르고\n얼굴을 인식시켜 미션 완료까지 혀를 내미세요!", missionColor: .mint, arstate: "smile")
]
