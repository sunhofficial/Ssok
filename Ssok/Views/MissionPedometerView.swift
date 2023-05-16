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
    let motionmanager = CMMotionManager()
    let activityManager = CMMotionActivityManager()
    
    @State var Title: String
    @State var TitleColor: Color
    @State var GoalCount: String
    
    @State var stepcount: Float = 0
    
    @State var currentgravity = 0
    @State var previousgravity = 0
    @State var gravityx: Double = 0
    @State var gravityy: Double = 0
    @State var gravityz: Double = 0
    @State var backstate: Bool = false

    @State var progressColor: Color = Color("Progress_first")
    let more: String = "더"
    @State var ismore: Int = 0
    @Binding var st: Bool
    
    var body: some View {
        
        ZStack {
            VStack {
                MissionTopView(title: "만보기", description: "춤을 춰서 만보기의 횟수를 채워야 해요.")
                Spacer()
            }
            VStack(spacing: 64) {

                MissionTitleView(missionTitle: Title, backgroundColor: TitleColor.opacity(0.28), borderColor: TitleColor.opacity(0.71))
                
                ZStack {
                    ZStack {
                        Circle()
                            .stroke(style: StrokeStyle(lineWidth: 25.0, lineCap: .round, lineJoin: .round))
                            .foregroundColor(Color("Gray"))
                            .shadow(color: Color.black.opacity(0.25), radius: 2, x: 0, y: -2)
                        Circle()
                            .trim(from: 0.0, to: GoalCount == "40.0" ? CGFloat(stepcount/40.0) : CGFloat(stepcount/10.0))
                            .stroke(style: StrokeStyle(lineWidth: 25.0, lineCap: .round, lineJoin: .round))
                            .rotationEffect(.degrees(270))
                            .foregroundColor(progressColor)
                    }.frame(width: 308, height: 308)
                    
                    VStack {
                        Text("\(stepcount, specifier: "%.0f")").font(.system(size: 60, weight: .bold)) + Text("회").font(.system(size: 40, weight: .bold))
                        Text("목표 진동수\n")
                            .font(.system(size: 18))
                            .multilineTextAlignment(.center)
                            .foregroundColor(Color("GoalRed"))
                        Text(GoalCount == "40.0" ? "40회" : "10회")
                            .font(.system(size: 18))
                            .multilineTextAlignment(.center)
                            .foregroundColor(Color("GoalRed"))
                    }
                }
                HStack{
                    Text(more).foregroundColor(Color.black)
                    Text(more).foregroundColor(ismore>=1 ? Color.black : Color("Gray"))
                    Text(more).foregroundColor(ismore>=2 ? Color.black : Color("Gray"))
                    Text(more).foregroundColor(ismore>=3 ? Color.black : Color("Gray"))
                }.font(.system(size: 48, weight: .bold))
                .onChange(of: stepcount) { value in
                    if GoalCount == "40.0"{
                        if stepcount == 10{
                            ismore += 1
                        } else if stepcount == 20 {
                            ismore += 1
                        } else if stepcount == 30 {
                            ismore += 1
                        }
                    }
                    else {
                        if stepcount == 3{
                            ismore += 1
                        } else if stepcount == 5 {
                            ismore += 1
                        } else if stepcount == 8 {
                            ismore += 1
                        }
                    }
                }
            }
            .padding(.top, 80)
            .onReceive(timer) { input in
                
                if motionmanager.isDeviceMotionAvailable {
                    motionmanager.deviceMotionUpdateInterval = 0.2
                    motionmanager.startDeviceMotionUpdates(to: OperationQueue.main) { data,error in
                        gravityx = data?.gravity.x ?? 0
                        
                        if gravityx > 0.15 || gravityy > 0.15 || gravityz > 0.15 {
                            currentgravity = 1
                        } else if gravityx <= 0.15 && gravityx >= -0.15 && gravityy <= 0.15 && gravityy >= -0.15 && gravityz <= 0.15 && gravityz >= -0.15 {
                            currentgravity = 0
                        } else if gravityx < -0.15 || gravityy < -0.15 || gravityz < 0.15 {
                            currentgravity = 2
                        }
                        
                        if currentgravity == previousgravity && previousgravity != 0 {
                            previousgravity = currentgravity
                        } else if currentgravity != previousgravity{
                            if GoalCount == "40.0"{
                                if stepcount != 40.0 {
                                    stepcount += 1.0
                                }
                            } else {
                                if stepcount != 10.0{
                                    stepcount += 1.0
                                }
                            }
                            previousgravity = currentgravity
                        }
                    }
                    
                }
                if GoalCount == "10.0" {
                    if stepcount <= 3 && stepcount > 1 {
                        progressColor = Color("Progress_second")
                    } else if stepcount <= 6 && stepcount > 3 {
                        progressColor = Color("Progress_third")
                    } else if stepcount <= 8 && stepcount > 6 {
                        progressColor = Color("Progress_final")
                    }
                }
                else if GoalCount == "40.0" {
                    if stepcount <= 20 && stepcount > 10 {
                        progressColor = Color("Progress_second")
                    } else if stepcount <= 30 && stepcount > 20 {
                        progressColor = Color("Progress_third")
                    } else if stepcount <= 40 && stepcount > 30 {
                        progressColor = Color("Progress_final")
                    }
                }
            }
            if String(stepcount) == GoalCount  {
                MissionCompleteView(Title: Title, background: TitleColor, st: $st)
            }
        }.navigationBarHidden(true)
    }
}

//struct MissionPedometerView_Previews: PreviewProvider {
//    static var previews: some View {
//        MissionPedometerView(Title: "춤추기 💃🕺🏻", TitleColor: Color("MissionPurple"), GoalCount: "100.0")
//    }
//}
