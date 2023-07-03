//
//  MissonDecibelView.swift
//  Ssok
//
//  Created by 김민 on 2023/05/14.
//

import SwiftUI

struct MissionDecibelView: View {
    @State var title: String
    @State var goal: String
    @State var progressValue = 0
    @State var progressTintColor = Color(.orange)
    @Binding var state: Bool
    @Binding var largePearlIndex: Int
    @StateObject private var viewModel = MissionDecibelViewModel()

    let progressColors = [Color("Progress1"), Color("Progress2"), Color("Progress3"), Color("Progress4")]
    let moreIndexes = [1, 2, 3, 4]

    var body: some View {
        ZStack {
            VStack {
                MissionTopView(title: "데시벨 측정기",
                               description: "미션을 성공하려면 데시벨을 충족시켜야 해요.")
                MissionTitleView(missionTitle: title,
                                 missionColor: Color("MissionDecibel"))
                    .padding(.top, UIScreen.getHeight(5))
                    .padding(.bottom, UIScreen.getHeight(60))
                ZStack {
                    ZStack {
                        Circle()
                            .stroke(style: StrokeStyle(lineWidth: UIScreen.getHeight(25),
                                                       lineCap: .round,
                                                       lineJoin: .round))
                            .foregroundColor(Color("Gray"))
                            .shadow(color: Color.black.opacity(0.25),
                                    radius: 2,
                                    x: 0,
                                    y: -2)
                        Circle()
                            .trim(from: 0.0,
                                  to: CGFloat(viewModel.setPercentage(goal)))
                            .stroke(style: StrokeStyle(lineWidth: UIScreen.getWidth(25),
                                                       lineCap: .round, lineJoin: .round))
                            .foregroundColor(progressTintColor)
                            .rotationEffect(.degrees(270))
                            .animation(.linear,
                                       value: viewModel.setPercentage(goal))
                            .onReceive(viewModel.$decibels) { _ in
                                viewModel.isMissionCompleted(goal)
                            }
                            .onChange(of: viewModel.setPercentage(goal)) { percentage in
                                switch percentage {
                                case ..<0.25:
                                    progressValue = 1
                                    progressTintColor = progressColors[0]
                                case 0.25..<0.5:
                                    progressValue = 2
                                    progressTintColor = progressColors[1]
                                case 0.5..<0.75:
                                    progressValue = 3
                                    progressTintColor = progressColors[2]
                                default:
                                    progressValue = 4
                                    progressTintColor = progressColors[3]
                                }
                            }
                    }
                    .padding(.horizontal, UIScreen.getWidth(41))

                    VStack {
                        Text(String(format: "%.f", viewModel.decibels))
                            .font(Font.custom60bold())
                            + Text("dB")
                            .font(Font.custom40bold())
                        Text("목표 데시벨\n\(goal)dB")
                            .font(Font.customTitle4())
                            .multilineTextAlignment(.center)
                            .foregroundColor(Color("GoalRed"))
                    }
                }
                HStack {
                    ForEach(moreIndexes, id: \.self) { index in
                        Text("더")
                            .foregroundColor(progressValue >= index ? Color.black : Color("Gray"))
                    }
                }
                .font(Font.custom48bold())
                .padding(.top, UIScreen.getHeight(60))
                .padding(.bottom, UIScreen.getHeight(50))

                Spacer()
            }
            .navigationBarHidden(true)

            if viewModel.isCompleted {
                MissionCompleteView(title: title,
                                    background: Color("MissionDecibel"),
                                    state: $state,
                                    largePearlIndex: $largePearlIndex)
            }
        }
        .onAppear {
            try? viewModel.start()
        }
        .onDisappear {
            viewModel.stop()
        }
    }
}

struct MissionDecibelView_Previews: PreviewProvider {
    static var previews: some View {
        MissionDecibelView(title: "콧바람 장풍 불기 💨",
                           goal: "90",
                           state: .constant(true),
                           largePearlIndex: .constant(0))
    }
}
