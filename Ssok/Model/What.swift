//
//  What.swift
//  6Bubbles
//
//  Created by 235 on 2023/05/06.
//

import Foundation
import SwiftUI

let whatList = ["하늘보기","춤추기","팔굽혀펴기하기","노래틀기","신발벗기","커피 타오기","새삥춤추기","셀카찍기","틱톡찍기","물구나무서기","플랭크하기(1분)","앞머리까기","마이크로 노래하기","소리지르기","틴트바르기","입술닦아주기","틴트발라주기","큰절하기","정수리냄새 맡아주기","대자로눕기"]


enum MissionType {
    case decibel, shake, voice, face
}

//struct Mission {
//    let missionType: MissionType
//    let title: String
//    let description: String
//    let goal: String
//    let timer: Double?
//    let smileRight: Float?
//    let smileLeft: Float?
//    let blinkLeft: Float?
//    let blinkRight: Float?
//    let mainColor: Color
//}

protocol MissionProtocol {
    var missionType: MissionType { get }
    var title: String { get }
    var description: String { get }
    var mainColor: Color { get }
}

struct DecibelMission: MissionProtocol {
    let missionType: MissionType
    let title: String
    let description: String
    let mainColor: Color
    let goalDecibel: String
}

struct PedoMeterMission: MissionProtocol {
    let missionType: MissionType
    let title: String
    let description: String
    let mainColor: Color
    let goalShaking: String
}

struct VoiceMission: MissionProtocol {
    let missionType: MissionType
    let title: String
    let description: String
    let mainColor: Color
    let sentence: String
    let timer: Double
}

struct FaceMission: MissionProtocol {
    let missionType: MissionType
    let title: String
    let description: String
    let mainColor: Color
    let smileRight: Float
    let smileLeft: Float
    let blinkLeft: Float
    let blinkRight: Float
}

let missions: [MissionProtocol] = [
    DecibelMission(missionType: .decibel, title: "소리 지르기", description: "장소로 이동해서 미션하기 버튼을 누르고\n소리를 질러 목표 데시벨을 채우세요", mainColor: .orange, goalDecibel: "100"),
    PedoMeterMission(missionType: .shake, title: "춤추기", description: "장소로 이동해서 미션하기 버튼을 누르고\n자신있는 춤을 열심히 춰서 진동 횟수를 채워요!", mainColor: .purple, goalShaking: "100"),
    VoiceMission(missionType: .voice, title: "혀놀리기", description: "장소로 이동해서 미션하기 버튼을 누르고\n주어진 문장을 읽을 준비 후 말하기 버튼을 눌러\n시간 안에 크고 정확하게 따라 읽어요!", mainColor: .blue, sentence: "간장공장공장장", timer: 5.0),
    FaceMission(missionType: .face, title: "플러팅하기", description: "장소를 이동해서 미션하기 버튼을 누르고\n얼굴을 인식시켜 미션 완료까지 두 눈을 윙크하세요!", mainColor: .green, smileRight: 0, smileLeft: 0, blinkLeft: 0, blinkRight: 0)
]
