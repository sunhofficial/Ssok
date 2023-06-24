//
//  MissionEndingView.swift
//  Ssok
//
//  Created by 김용주 on 2023/05/14.
//

import SwiftUI

struct MissionEndingView: View {
    @Binding var state: Bool
    @State var next = false
    @State var wheresentence: String = ""
    @State var whatsentence: String = ""
    @State var missionTitle: String
    @State var missionTip: String
    @State var missionColor: Color
    @State var goal: String = ""
    @EnvironmentObject var random: RandomMember
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>

    var body: some View {
        ZStack {
            ZStack(alignment: .top) {
                Image("imgEndingTop").resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: screenWidth).position(x: screenWidth/2, y: 190)
                HStack {
                    Spacer()
                    HStack {
                        Image("imgRetry")
                        Text("다시뽑기")
                            .font(.system(size: 17, weight: .semibold))
                            .foregroundColor(.white)
                    }
                    .onTapGesture {
                        random.randomWho = setRandomMember(random.members)
                        random.randomWhat = setRandomMission(missions)
                        random.randomWhere = setRandomWhere(whereList)
                        state = false
                    }
                    .padding(.trailing, 20)
                    .padding(.top, 56)
                }
            }
            ZStack {
                Text(random.randomWho)
                    .font(.system(size: 20, weight: .bold))
                    .rotationEffect(Angle(degrees: -30))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .minimumScaleFactor(0.1)
                    .frame(width: 75, height: 75)
                    .lineLimit(2)
                    .position(x: screenWidth/2.9, y: 210)
                Text(random.randomWhere)
                    .font(.system(size: 20, weight: .bold))
                    .rotationEffect(Angle(degrees: -30))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .minimumScaleFactor(0.1)
                    .frame(width: 75, height: 75)
                    .lineLimit(2)
                    .position(x: screenWidth/1.81, y: 210)
                Text(String(random.randomWhat.missionDetail.missionTitle.dropLast(2)))
                    .font(.system(size: 20, weight: .bold))
                    .rotationEffect(Angle(degrees: -30))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .minimumScaleFactor(0.1)
                    .frame(width: 75, height: 75)
                    .lineLimit(2)
                    .position(x: screenWidth/1.155, y: 210)
            }
            ZStack {
                Circle()
                    .foregroundColor(.white)
                    .frame(width: 50, height: 50)
                    .shadow(color: Color("Bg_bottom2"), radius: 2)
                Text("📢")
                    .frame(width: 50, height: 50)
            }
            VStack(spacing: 8) {
                switch random.randomWhat.missionType {
                case .decibel:
                    Text("데시벨 측정기")
                        .font(.system(size: 24, weight: .black))
                    Text("미션을 성공하려면 데시벨을 충족시켜야해요")
                        .font(.system(size: 13, weight: .light))
                case .shake:
                    Text("만보기")
                        .font(.system(size: 24, weight: .black))
                    Text("춤을 춰서 만보기의 횟수를 채워야해요")
                        .font(.system(size: 13, weight: .light))
                case .voice:
                    Text("따라 읽기")
                        .font(.system(size: 24, weight: .black))
                    Text("주어진 문장을 정확하게 따라 읽어서 인식시켜요")
                        .font(.system(size: 13, weight: .light))
                default:
                    Text("얼굴 인식")
                        .font(.system(size: 24, weight: .black))
                    Text("미션을 성공하려면 얼굴을 인식해야해요.")
                        .font(.system(size: 13, weight: .light))
                }
                ZStack {
                    RoundedRectangle(cornerRadius: 20)
                        .strokeBorder(Color("Border"), lineWidth: 1.5)
                        .frame(width: 295, height: 175)
                    Text("미션 성공 TIP")
                        .font(.system(size: 20, weight: .black))
                        .foregroundColor(Color("Bg_bottom2"))
                    VStack(spacing: 50) {
                        MissionTitleView(
                            missionTitle: missionTitle,
                            backgroundColor: missionColor.opacity(0.35),
                            borderColor: missionColor.opacity(0.71)
                        )
                        Text(missionTip)
                            .font(.system(size: 13, weight: .medium))
                            .multilineTextAlignment(.center)
                    }
                }
                .offset(y: 32)
            }
            .offset(y: 150)
            NavigationLink {
                switch random.randomWhat.missionType {
                case .decibel:
                    MissionDecibelView(title: missionTitle,
                                       missionColor: missionColor,
                                       goal: random.randomWhat.detail["goal"] ?? "",
                                       state: $state)
                case .shake:
                    MissionPedometerView(title: missionTitle,
                                         titleColor: missionColor,
                                         goalCount: random.randomWhat.detail["goal"] ?? "",
                                         state: $state)
                case .voice:
                    MissionSpeechView(missionTitle: missionTitle,
                                      missionTip: missionTip,
                                      missionColor: missionColor,
                                      answerText: random.randomWhat.detail["goal"] ?? "",
                                      speechTime: Double(random.randomWhat.detail["timer"] ?? "30")!,
                                      state: $state)
                default:
                    EmptyView()
                }
            } label: {
                Text("미션하기")
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .frame(maxWidth: 350, maxHeight: 50, alignment: .center)
                    .background(Color("Bg_bottom2"))
                    .cornerRadius(12)
            }
            .position(x: screenWidth/2, y: screenHeight-59)
        }
        .ignoresSafeArea(.all)
        .navigationBarHidden(true)
    }
}
