//
//  MissionEndingView.swift
//  Ssok
//
//  Created by 김용주 on 2023/05/14.
//

import SwiftUI

struct MissionEndingView: View {
    @Binding var state: Bool
    @State private var isPresented = false
    @State var missionTitle: String
    @State var missionTip: String
    @State var goal: String = ""
    @Binding var largePearlIndex: Int
    @EnvironmentObject var random: RandomMember
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>

    var body: some View {
        GeometryReader { geomtry in
            VStack {
                ZStack(alignment: .top) {
                    Image("imgEndingTop")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                    HStack {
                        Spacer()
                        HStack {
                            Image("imgRetry")
                            Text("다시뽑기")
                                .font(Font.custom17semi())
                                .foregroundColor(.white)
                        }
                        .onTapGesture {
                            random.randomWho = setRandomMember(random.members)
                            random.randomWhat = setRandomMission(missions)
                            random.randomWhere = setRandomWhere(howList)
                            state = false
                        }
                        .padding(.trailing, UIScreen.getWidth(20))
                        .padding(.top, UIScreen.getHeight(60))
                    }
                    HStack {
                        Text(random.randomWho)
                            .font(Font.custom15bold())
                            .rotationEffect(Angle(degrees: -30))
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                            .minimumScaleFactor(0.1)
                            .frame(width: UIScreen.getWidth(75), height: UIScreen.getHeight(75))
                            .lineLimit(2)
                        Text(random.randomWhere)
                            .font(Font.custom15bold())
                            .rotationEffect(Angle(degrees: -30))
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                            .minimumScaleFactor(0.1)
                            .frame(width: UIScreen.getWidth(75), height: UIScreen.getHeight(75))
                            .lineLimit(2)
                        Spacer()
                        Text(String(random.randomWhat.missionInfo.missionTitle.dropLast(2)))
                            .font(Font.custom15bold())
                            .rotationEffect(Angle(degrees: -30))
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                            .minimumScaleFactor(0.1)
                            .frame(width: UIScreen.getWidth(75), height: UIScreen.getHeight(75))
                            .lineLimit(2)
                    }
                    .onTapGesture {
                        random.randomWho = setRandomMember(random.members)
                        random.randomWhat = setRandomMission(missions)
                        random.randomWhere = setRandomWhere(howList)
                        largePearlIndex = -1
                        state = false
                    }
                    .padding(.leading, UIScreen.getWidth(100))
                    .padding(.trailing, UIScreen.getWidth(18))
                    .padding(.top,getSafeArea().bottom == 0 ?
                             UIScreen.getHeight(210) : UIScreen.getHeight(170))
                }
                .offset(x:0, y: getSafeArea().bottom == 0 ? 0 :  -geomtry.safeAreaInsets.top )
                .frame(maxHeight: geomtry.size.height/2)
                VStack {
                    VStack(spacing: UIScreen.getHeight(10)) {
                        ZStack {
                            Circle()
                                .foregroundColor(.white)
                                .shadow(color: Color("Bg_bottom2"), radius: 2)
                            Text("📢")
                        }
                        .padding(.horizontal,UIScreen.getWidth(170))
                        let mission = random.randomWhat.missionType
                        switch mission {
                        case .decibel:
                            MissionTypeView(title: "데시벨 측정기",
                                            description: "미션을 성공하려면 데시벨을 충족시켜야해요")
                        case .shake:
                            MissionTypeView(title: "만보기",
                                            description: "춤을 춰서 만보기의 횟수를 채워야해요")
                        case .voice:
                            MissionTypeView(title: "따라 읽기",
                                            description: "주어진 문장을 정확하게 따라 읽어서 인식시켜요")
                        case .smile, .blink:
                            MissionTypeView(title: "얼굴 인식",
                                            description: "미션을 성공하려면 얼굴을 인식해야해요.")
                        }}
                    .padding(.top,UIScreen.getHeight(16))
                    .offset(x:0,y:-geomtry.safeAreaInsets.top)
                    RoundedRectangle(cornerRadius: 20)
                        .strokeBorder(Color("Border"), lineWidth: 1.5)
                        .frame(minHeight: UIScreen.getHeight(175))
                        .padding(.horizontal,UIScreen.getWidth(50))
                        .padding(.top,UIScreen.getHeight(20))
                        .overlay(
                            VStack(spacing: UIScreen.getHeight(15)) {
                                let mission = random.randomWhat.missionType
                                switch mission {
                                case .decibel:
                                    MissionTitleView(missionTitle: missionTitle,
                                                     missionColor: Color("MissionDecibel"))
                                case .shake:
                                    MissionTitleView(missionTitle: missionTitle,
                                                     missionColor: Color("MissionShake"))
                                case .voice:
                                    MissionTitleView(missionTitle: missionTitle,
                                                     missionColor: Color("MissionVoice"))
                                case .smile, .blink:
                                    MissionTitleView(missionTitle: missionTitle,
                                                     missionColor: Color("MissionFace"))
                                }
                                Text("미션 성공 TIP")
                                    .font(Font.custom20bold())
                                    .foregroundColor(Color("Bg_bottom2"))
                                Text(missionTip)
                                    .font(Font.custom13semibold())
                                    .multilineTextAlignment(.center)
                                    .padding(.bottom,UIScreen.getHeight(15))
                            }
                        .padding(.top, UIScreen.getHeight(20))
                        )
                        .offset(x:0,y:-geomtry.safeAreaInsets.top )

                    Button {
                        isPresented.toggle()
                    } label: {
                        Text("미션하기")
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, UIScreen.getHeight(15))
                            .background(Color("Bg_bottom2"))
                            .cornerRadius(12)
                    }
                    .padding(.horizontal, UIScreen.getWidth(20))
                    .padding(.vertical,UIScreen.getHeight(5))
                    .offset(x:0,y: -geomtry.safeAreaInsets.top)
                }
            }
            .navigationBarHidden(true)
            .fullScreenCover(isPresented: $isPresented) {
                let mission = random.randomWhat.missionType
                switch mission {
                case .decibel:
                    MissionDecibelView(title: missionTitle,
                                       goal: random.randomWhat.missionDetail[MissionDetail.goal] ?? "",
                                       state: $state,
                                       largePearlIndex: $largePearlIndex)
                case .shake:
                    MissionPedometerView(title: missionTitle,
                                         goalCount: random.randomWhat.missionDetail[MissionDetail.goal] ?? "",
                                         state: $state,
                                         largePearlIndex: $largePearlIndex)
                case .voice:
                    MissionSpeechView(missionTitle: missionTitle,
                                      missionTip: missionTip,
                                      answerText: random.randomWhat.missionDetail[MissionDetail.answer] ?? "",
                                      speechTime: Double(random
                                        .randomWhat
                                        .missionDetail[MissionDetail.timer] ?? "30")!,
                                      state: $state,
                                      largePearlIndex: $largePearlIndex)
                case .smile, .blink:
                    MissionSmileView(arViewState:
                                     random.randomWhat.missionDetail[MissionDetail.arState] ?? "",
                                     state: $state,
                                     largePearlIndex: $largePearlIndex
                    )
                }
            }
        }
    }
//    private struct TextModifier: ViewModifier {
//        let xFactor: CGFloat
//
//        func body(content: Content) -> some View {
//            content
//                .font(Font.custom20bold())
//                .rotationEffect(Angle(degrees: -30))
//                .foregroundColor(.white)
//                .multilineTextAlignment(.center)
//                .minimumScaleFactor(0.1)
//                .frame(width: UIScreen.getWidth(75), height: UIScreen.getWidth(75))
//                .lineLimit(2)
//                .position(x: UIScreen.getWidth(xFactor), y: UIScreen.getHeight(166))
//        }
//    }
}
