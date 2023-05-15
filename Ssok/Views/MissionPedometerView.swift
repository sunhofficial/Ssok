//
//  MissionPedometerView.swift
//  Ssok
//
//  Created by 김민 on 2023/05/14.
//

import SwiftUI
import CoreMotion

struct MissionPedometerView: View {
    
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

    @State var limit: Float = 100.0
    @State var progressColor: Color = Color("Progress_first")
    let more: String = "더"
    @State var ismore: Int = 0
    
    var body: some View {
        
        ZStack {
            VStack(spacing: 64) {
                MissionTopView(title: "만보기", description: "춤을 춰서 만보기의 횟수를 채워야 해요")
                
                MissionTitleView(missionTitle: Title, backgroundColor: TitleColor.opacity(0.35), borderColor: TitleColor.opacity(0.71))
                
                ZStack {
                    ZStack {
                        Circle()
                            .stroke(style: StrokeStyle(lineWidth: 25.0, lineCap: .round, lineJoin: .round))
                            .foregroundColor(Color("Gray"))
                            .shadow(color: Color.black.opacity(0.25), radius: 2, x: 0, y: -2)
                        Circle()
                            .trim(from: 0.0, to: CGFloat(stepcount/100.0))
                            .stroke(style: StrokeStyle(lineWidth: 25.0, lineCap: .round, lineJoin: .round))
                            .rotationEffect(.degrees(270))
                            .foregroundColor(progressColor)
                    }.frame(width: 308, height: 308)
                    
                    VStack {
                        Text("\(stepcount, specifier: "%.0f")").font(.system(size: 60, weight: .bold)) + Text("회").font(.system(size: 40, weight: .bold))
                        Text("목표 진동수\n100회")
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
                .padding(.bottom, 94)
                .onChange(of: stepcount) { value in
                    if stepcount == 25{
                        ismore += 1
                    } else if stepcount == 50 {
                        ismore += 1
                    } else if stepcount == 75 {
                        ismore += 1
                    }
                }
            }
            .onReceive(timer) { input in
                
                if motionmanager.isDeviceMotionAvailable {
                    motionmanager.deviceMotionUpdateInterval = 0.2
                    motionmanager.startDeviceMotionUpdates(to: OperationQueue.main) { data,error in
                        gravityx = data?.gravity.x ?? 0
                        
                        if gravityx > 0.2 || gravityy > 0.2 || gravityz > 0.2 {
                            currentgravity = 1
                        } else if gravityx <= 0.2 && gravityx >= -0.2 && gravityy <= 0.2 && gravityy >= -0.2 && gravityz <= 0.2 && gravityz >= -0.2 {
                            currentgravity = 0
                        } else if gravityx < -0.2 || gravityy < -0.2 || gravityz < 0.2 {
                            currentgravity = 2
                        }
                        
                        if currentgravity == previousgravity && previousgravity != 0 {
                            previousgravity = currentgravity
                        } else if currentgravity != previousgravity{
                            if stepcount != 100.0 {
                                stepcount += 1.0
                            }
                            previousgravity = currentgravity
                        }
                    }
                    
                }
                
                if stepcount <= 50 && stepcount > 25 {
                    progressColor = Color("Progress_second")
                } else if stepcount <= 75 && stepcount > 50 {
                    progressColor = Color("Progress_third")
                } else if stepcount <= 100 && stepcount > 75 {
                    progressColor = Color("Progress_final")
                }
            }
            if String(stepcount) == GoalCount {
                MissionCompleteView(Title: Title, background: TitleColor)
            }
        }.navigationBarHidden(true)
    }
}

struct MissionPedometerView_Previews: PreviewProvider {
    static var previews: some View {
        MissionPedometerView(Title: "춤추기 💃🕺🏻", TitleColor: Color("MissionPurple"), GoalCount: "100.0")
    }
}
