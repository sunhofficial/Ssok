//
//  ContentView.swift
//  PraticeSoundcheck
//
//  Created by 235 on 2023/05/13.
//

import SwiftUI

struct MissionSpeechView: View {

    @StateObject var speechRecognizer = SpeechRecognizer()
    @State var isSpeech: Bool = true
    @State var isWrong: Bool = false
    @State var isComplete: Bool = false
    @State var havetext: Bool = false
    @State var missionTitle: String
    @State var missionTip: String
    @State var missionColor: Color
    @State var answerText: String
    @State var speechTime: Double
    @State var progressTime: Double = 100.0
    @State var checkTimer: Timer?
    @Binding var state: Bool
    let progressTimer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()

    var body: some View {
        ZStack {
            VStack {
                MissionTopView(title: "따라읽기", description: "주어진 문장을 정확하게 따라 읽어서 인식시켜요.")
                Spacer()
                if isSpeech {
                    Image("progress")
                        .shadow(color: Color(.black).opacity(0.25), radius: 4)
                        .overlay(
                            ProgressView(value: progressTime, total: 100)
                                .tint(Color("Bg_bottom2"))
                                .background(Color("LightGray"))
                                .frame(width: 260, height: 8)
                                .scaleEffect(x: 1, y: 2)
                                .clipShape(RoundedRectangle(cornerRadius: 4))
                                .padding(.top, 17)
                                .onReceive(progressTimer) { _ in
                                    withAnimation(.easeInOut(duration: 0.1)) {
                                        if progressTime > 0 {
                                            progressTime -= 0.1 * (100 / speechTime)
                                        }
                                    }
                                }
                        )
                        .frame(height: 50)
                        .onAppear {
                            if missionTitle == "영국 신사 되기 💂🏻‍♀️" {
                                speechRecognizer.englishTranscribing()
                            } else {
                                speechRecognizer.startTranscribing()
                            }
                            let timer = Timer.scheduledTimer(withTimeInterval: speechTime, repeats: false) {  _ in
                                let cleanedTranscript = speechRecognizer.transcript
                                    .replacingOccurrences(of: " ", with: "")
                                    .replacingOccurrences(of: ",", with: "")
                                if answerText
                                    .replacingOccurrences(of: " ", with: "")
                                    .replacingOccurrences(of: ",", with: "") != cleanedTranscript {
                                    isWrong = true
                                    isSpeech = false
                                }
                            }
                            checkTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
                                let cleanedTranscript = speechRecognizer.transcript
                                    .replacingOccurrences(of: " ", with: "")
                                    .replacingOccurrences(of: ",", with: "")
                                if answerText
                                    .replacingOccurrences(of: " ", with: "")
                                    .replacingOccurrences(of: ",", with: "") == cleanedTranscript {
                                    timer.invalidate()
                                    isComplete = true
                                    speechRecognizer.stopTranscript()
                                }
                            }
                            RunLoop.main.add(checkTimer!, forMode: .common)
                            RunLoop.main.add(timer, forMode: .common)
                        }
                        .onDisappear {
                            speechRecognizer.stopTranscript()
                        }
                } else {
                    Button {
                        isSpeech = true
                        speechRecognizer.transcript = ""
                        progressTime = 100
                        isWrong = false
                    } label: {
                        Text("다시 말하기")
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                            .frame(maxWidth: 350, alignment: .center)
                            .frame(height: 50)
                            .background(Color("Bg_bottom2"))
                            .cornerRadius(12)
                    }
                }
            }
            VStack(spacing: 40) {
                MissionTitleView(missionTitle: missionTitle,
                                 backgroundColor: missionColor.opacity(0.3),
                                 borderColor: missionColor.opacity(0.71))
                VStack(spacing: 44) {
                    // 제시어 카드
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .frame(width: 307, height: 175)
                            .foregroundColor(.white)
                            .shadow(color: Color(.black).opacity(0.2), radius: 8)
                            .background(
                                RoundedRectangle(cornerRadius: 20)
                                    .frame(width: 284, height: 175)
                                    .foregroundColor(.white)
                                    .shadow(color: Color(.black).opacity(0.2), radius: 8)
                                    .offset(y: 12)
                                    .background(
                                        RoundedRectangle(cornerRadius: 20)
                                            .frame(width: 268, height: 175)
                                            .foregroundColor(.white)
                                            .shadow(color: Color(.black).opacity(0.2), radius: 8)
                                            .offset(y: 22)
                                    )
                            )
                        VStack(spacing: 20) {
                            Text("따라 읽어요")
                                .font(.system(size: 13, weight: .semibold))
                                .padding(.horizontal, 9)
                                .padding(.vertical, 4)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 15)
                                        .stroke(Color("Orange"), lineWidth: 1.5)
                                )
                                .foregroundColor(Color("Orange"))
                            Text(answerText)
                                .font(.system(size: 48, weight: .heavy))
                                .frame(width: 240, height: 64)
                                .minimumScaleFactor(0.1)
                                .multilineTextAlignment(.center)
                                .lineLimit(2)
                        }
                    }
                    // 제시어 말하기
                    ZStack {
                        Image("speeching")
                            .shadow(color: Color("Orange").opacity(0.5), radius: 5)
                        VStack {
                            Text("내 발음")
                                .font(.system(size: 13, weight: .semibold))
                                .padding(.horizontal, 9)
                                .padding(.vertical, 4)
                                .background(Color("Orange"))
                                .cornerRadius(15)
                                .foregroundColor(.white)
                            if speechRecognizer.transcript == "" {
                                    Text("문장을 따라 읽어주세요")
                                        .opacity(0.25)
                                        .font(.system(size: 48, weight: .heavy))
                                        .frame(width: 240, height: 64)
                                        .minimumScaleFactor(0.1)
                                        .lineLimit(1)
                            } else {
                                Text(speechRecognizer.transcript)
                                    .font(.system(size: 48, weight: .heavy))
                                    .frame(width: 240, height: 64)
                                    .minimumScaleFactor(0.1)
                                    .multilineTextAlignment(.center)
                                    .lineLimit(2)
                            }
                            if isWrong {
                                Text("❌ 제시어와 달라요 다시 읽어 주세요 ❌")
                                    .font(.system(size: 13, weight: .semibold))
                                    .padding(.vertical, 2)
                                    .background(Color("LightRed"))
                                    .foregroundColor(Color("Red"))
                            }
                        }
                        .padding(.top)
                    }
                    .padding(.top, 3)
                }
            }
            .padding(.top, 40)
            if isComplete {
                MissionCompleteView(title: missionTitle, background: missionColor, state: $state)
            }
        }
        .navigationBarHidden(true)
        .onDisappear {
            speechRecognizer.stopTranscript()
            checkTimer?.invalidate()
            checkTimer = nil
        }
    }
}
