//
//  MissionPedometerView.swift
//  Ssok
//
//  Created by 김민 on 2023/05/14.
//

import SwiftUI
import CoreMotion

struct MissionPedometerView: View {
    let timer = Timer.publish(every: 0.5, on: .main, in: .common).autoconnect()
    let motionManager = CMMotionManager()
    let activityManager = CMMotionActivityManager()
    @State var title: String
    @State var goalCount: String
    @State private var stepCount: Float = 0
    @State private var currentGravity = 0
    @State private var previousGravity = 0
    @State private var gravityX: Double = 0
    @State private var gravityY: Double = 0
    @State private var gravityZ: Double = 0
    @State private var backState: Bool = false
    @State var progressColor: Color = Color("Progress_first")
    private let more: String = "더"
    @State private var isMore: Int = 0
    @Binding var state: Bool

    var body: some View {
        ZStack {
            VStack {
                MissionTopView(title: "만보기", description: "춤을 춰서 만보기의 횟수를 채워야 해요.")
                Spacer()
            }
            VStack(spacing: 64) {
                MissionTitleView(
                    missionTitle: title,
                    backgroundColor: Color("MissionShake").opacity(0.28),
                    borderColor: Color("MissionShake").opacity(0.71))
                ZStack {
                    ZStack {
                        Circle()
                            .stroke(style: StrokeStyle(lineWidth: 25.0, lineCap: .round, lineJoin: .round))
                            .foregroundColor(Color("Gray"))
                            .shadow(color: Color.black.opacity(0.25), radius: 2, x: 0, y: -2)
                        Circle()
                            .trim(from: 0.0,
                                  to: goalCount == "40.0" ? CGFloat(stepCount/40.0) : CGFloat(stepCount/10.0))
                            .stroke(style: StrokeStyle(lineWidth: 25.0, lineCap: .round, lineJoin: .round))
                            .rotationEffect(.degrees(270))
                            .foregroundColor(progressColor)
                    }.frame(width: 308, height: 308)

                    VStack {
                        Text("\(stepCount, specifier: "%.0f")")
                            .font(.system(size: 60, weight: .bold)) + Text("회")
                            .font(.system(size: 40, weight: .bold))
                        Text("목표 진동수\n")
                            .font(.system(size: 18))
                            .multilineTextAlignment(.center)
                            .foregroundColor(Color("GoalRed"))
                        Text(goalCount == "40.0" ? "40회" : "10회")
                            .font(.system(size: 18))
                            .multilineTextAlignment(.center)
                            .foregroundColor(Color("GoalRed"))
                    }
                }
                HStack {
                    Text(more).foregroundColor(Color.black)
                    Text(more).foregroundColor(isMore>=1 ? Color.black : Color("Gray"))
                    Text(more).foregroundColor(isMore>=2 ? Color.black : Color("Gray"))
                    Text(more).foregroundColor(isMore>=3 ? Color.black : Color("Gray"))
                }.font(.system(size: 48, weight: .bold))
                .onChange(of: stepCount) { _ in
                    if goalCount == "40.0"{
                        if stepCount == 10 {
                            isMore += 1
                        } else if stepCount == 20 {
                            isMore += 1
                        } else if stepCount == 30 {
                            isMore += 1
                        }
                    } else {
                        if stepCount == 3 {
                            isMore += 1
                        } else if stepCount == 5 {
                            isMore += 1
                        } else if stepCount == 8 {
                            isMore += 1
                        }
                    }
                }
            }
            .padding(.top, 80)
            .onReceive(timer) { _ in
                if motionManager.isDeviceMotionAvailable {
                    motionManager.deviceMotionUpdateInterval = 0.2
                    motionManager.startDeviceMotionUpdates(to: OperationQueue.main) { data, _ in
                        gravityX = data?.gravity.x ?? 0
                        if gravityX > 0.15 || gravityY > 0.15 || gravityZ > 0.15 {
                            currentGravity = 1
                        } else if abs(gravityX) <= 0.15 && abs(gravityY) <= 0.15 && abs(gravityZ) <= 0.15 {
                            currentGravity = 0
                        } else if gravityX < -0.15 || gravityY < -0.15 || gravityZ < 0.15 {
                            currentGravity = 2
                        }
                        if currentGravity == previousGravity && previousGravity != 0 {
                            previousGravity = currentGravity
                        } else if currentGravity != previousGravity {
                            if goalCount == "40.0"{
                                if stepCount != 40.0 {
                                    stepCount += 1.0
                                }
                            } else {
                                if stepCount != 10.0 {
                                    stepCount += 1.0
                                }
                            }
                            previousGravity = currentGravity
                        }
                    }
                }
                if goalCount == "10.0" {
                    if stepCount <= 3 && stepCount > 1 {
                        progressColor = Color("Progress_second")
                    } else if stepCount <= 6 && stepCount > 3 {
                        progressColor = Color("Progress_third")
                    } else if stepCount <= 8 && stepCount > 6 {
                        progressColor = Color("Progress_final")
                    }
                } else if goalCount == "40.0" {
                    if stepCount <= 20 && stepCount > 10 {
                        progressColor = Color("Progress_second")
                    } else if stepCount <= 30 && stepCount > 20 {
                        progressColor = Color("Progress_third")
                    } else if stepCount <= 40 && stepCount > 30 {
                        progressColor = Color("Progress_final")
                    }
                }
            }
            if String(stepCount) == goalCount {
                MissionCompleteView(
                    title: title,
                    background: Color("MissionShake"),
                    state: $state)
            }
        }
        .navigationBarHidden(true)
        .onAppear {
            if title.count == 5 { SoundManager.shared.playMusic() }
        }
        .onDisappear {
            if title.count == 5 { SoundManager.shared.pauseMusic() }
        }
    }
}
