//
//  MissonDecibelView.swift
//  Ssok
//
//  Created by 김민 on 2023/05/14.
//

import SwiftUI

struct MissionDecibelView: View {
    
    // MARK: - Properties
    
    @StateObject private var soundMeter = SoundMeter()
    @State var title: String
    @State var missionColor: Color
    @State var goal: String
    @State private var isCompleted = false
    @State private var more: String = "더"
    @State var ismore: Int = 0
    @State var progressTintColor = Color(.orange)
    
    var body: some View {
        
        ZStack {
            VStack {
                MissionTopView(title: "데시벨 측정기", description: "미션을 성공하려면 데시벨을 충족시켜야 해요.")
                Spacer()
            }
            VStack(spacing: 64) {
                MissionTitleView(missionTitle: title, backgroundColor: missionColor.opacity(0.3), borderColor: missionColor.opacity(0.7))
                ZStack {
                    ZStack {
                        Circle()
                            .stroke(style: StrokeStyle(lineWidth: 25.0, lineCap: .round, lineJoin: .round))
                            .foregroundColor(Color("Gray"))
                            .shadow(color: Color.black.opacity(0.25), radius: 2, x: 0, y: -2)
                        Circle()
                            .trim(from: 0.0, to: CGFloat(soundMeter.decibels/Float(goal)!))
                            .stroke(style: StrokeStyle(lineWidth: 25.0, lineCap: .round, lineJoin: .round))
                            .foregroundColor(self.progressTintColor)
                            .rotationEffect(.degrees(270))
                            .animation(.linear, value: soundMeter.decibels/Float(goal)!)
                            .onReceive(soundMeter.$decibels) { decibels in
                                if decibels >= Float(goal)! {
                                    withAnimation {
                                        isCompleted = true
                                        soundMeter.stop()
                                    }
                                }
                            }
                            .onChange(of: soundMeter.decibels/Float(goal)!) { value in
                                if soundMeter.decibels/Float(goal)! <= 0.25 {
                                    ismore = 0
                                    progressTintColor = Color("Progress1")
                                } else if soundMeter.decibels/Float(goal)! > 0.25 && soundMeter.decibels/Float(goal)! <= 0.5 {
                                    ismore = 1
                                    progressTintColor = Color("Progress2")
                                } else if soundMeter.decibels/Float(goal)! > 0.5 && soundMeter.decibels/Float(goal)! <= 0.75 {
                                    ismore = 2
                                    progressTintColor = Color("Progress3")
                                } else {
                                    ismore = 3
                                    progressTintColor = Color("Progress4")
                                }
                            }
                    }
                    .frame(width: 308, height: 308)

                    VStack {
                        Text( String(format: "%.f", soundMeter.decibels)
                        ).font(.system(size: 60, weight: .bold)) + Text("dB").font(.system(size: 40, weight: .bold))
                        Text("목표 데시벨\n\(goal)dB")
                            .font(.system(size: 18))
                            .multilineTextAlignment(.center)
                            .foregroundColor(Color("GoalRed"))
                    }
                }
                HStack{
                    Text(more).foregroundColor(Color.black)
                    Text(more).foregroundColor(ismore >= 1 ? Color.black : Color("Gray"))
                    Text(more).foregroundColor(ismore >= 2 ? Color.black : Color("Gray"))
                    Text(more).foregroundColor(ismore >= 3 ? Color.black : Color("Gray"))
                }.font(.system(size: 48, weight: .bold))
            }
            .padding(.top, 80)
            .navigationBarHidden(true)
            
            if isCompleted {
                MissionCompleteView(Title: title, background: missionColor)
            }
        }
        .onAppear {
            try? soundMeter.start()
        }
        .onDisappear {
            soundMeter.stop()
            soundMeter.decibels = 0.0
        }
    }
}

