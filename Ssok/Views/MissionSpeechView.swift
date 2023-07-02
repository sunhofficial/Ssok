//
//  ContentView.swift
//  PraticeSoundcheck
//
//  Created by 235 on 2023/05/13.
//

import SwiftUI

struct MissionSpeechView: View {
    @StateObject var speechRecognizer = SpeechViewModel()
    @State var isSpeech = true
    @State var isWrong = false
    @State var isComplete = false
    @State var havetext = false
    @State var missionTitle: String
    @State var answerText: String
    @State var speechTime: Double
    @State var progressTime = 100.0
    @State var checkTimer: Timer?
    @Binding var state: Bool
    @Binding var largePearlIndex: Int
    let progressTimer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()

    var body: some View {
        ZStack {
            VStack {
                MissionTopView(title: "따라읽기",
                               description: "주어진 문장을 정확하게 따라 읽어서 인식시켜요.")
                MissionTitleView(missionTitle: missionTitle,
                                 missionColor: Color("MissionVoice"))
                .padding(.top, UIScreen.getHeight(5))
                ZStack {
                    RoundedRectangle(cornerRadius: 20)
                        .padding(.horizontal, UIScreen.getWidth(40))
                        .foregroundColor(.white)
                        .shadow(color: Color(.black).opacity(0.2), radius: 8)
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .padding(.horizontal, UIScreen.getWidth(50))
                                .foregroundColor(.white)
                                .shadow(color: Color(.black).opacity(0.2), radius: 8)
                                .offset(y: 12)
                                .background(
                                    RoundedRectangle(cornerRadius: 20)
                                        .padding(.horizontal,UIScreen.getWidth(60))
                                        .foregroundColor(.white)
                                        .shadow(color: Color(.black).opacity(0.2), radius: 8)
                                        .offset(y: 22)
                                )
                        )
                    VStack(spacing: 20) {
                        Text("따라 읽어요")
                            .font(Font.custom13semibold())
                            .padding(.horizontal, UIScreen.getWidth(9))
                            .padding(.vertical, UIScreen.getHeight(4))
                            .overlay(
                                RoundedRectangle(cornerRadius: 15)
                                    .stroke(Color("Orange"), lineWidth: 1.5)
                            )
                            .foregroundColor(Color("Orange"))
                        Text(answerText)
                            .font(Font.custom40heavy())
                            .minimumScaleFactor(0.1)
                            .multilineTextAlignment(.center)
                            .lineLimit(2)
                    }
                }
                .padding(.top,40)
                ZStack {
                    Image("imgSpeeching")
                        .shadow(color: Color("Orange").opacity(0.5), radius: 5)
                    VStack {
                        Text("내 발음")
                            .font(Font.custom13semibold())
                            .padding(.horizontal, UIScreen.getWidth(10))
                            .padding(.vertical, UIScreen.getHeight(4))
                            .background(Color("Orange"))
                            .cornerRadius(15)
                            .foregroundColor(.white)
                        Text(speechRecognizer.transcript.isEmpty ?
                             "문장을 따라 읽어주세요" : speechRecognizer.transcript)
                        .opacity(speechRecognizer.transcript.isEmpty ? 0.25 : 1.0)
                        .font(Font.custom40heavy())
                        .minimumScaleFactor(0.1)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, UIScreen.getWidth(50))
                        .multilineTextAlignment(.center)
                        .lineLimit(speechRecognizer.transcript.isEmpty ? 1 : 2)
                        if isWrong {
                            Text("❌ 제시어와 달라요 다시 읽어 주세요 ❌")
                                .font(Font.custom13semibold())
                                .padding(.vertical, UIScreen.getHeight(2))
                                .background(Color("LightRed"))
                                .foregroundColor(Color("Red"))
                        }
                    }
                }
                .padding(.top, 3)
                if isSpeech {
                    Image("imgProgress")
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
                            let language = missionTitle == "영국 신사 되기 💂🏻‍♀️" ? "English" : "Korean"
                            speechRecognizer.startTranscribing(language: language)
                            let timer = Timer.scheduledTimer(
                                withTimeInterval: speechTime,
                                repeats: false
                            ) { _ in
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
            if isComplete {
                MissionCompleteView(title: missionTitle, background: Color("MissionVoice"), state: $state, largePearlIndex: $largePearlIndex)
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
struct MissionSpeechView_Previews: PreviewProvider {
    static var previews: some View {
        MissionSpeechView(missionTitle: "test입니다",
                          answerText: "이것은test",
                          speechTime: 4.0,
                          state: .constant(false),
                          largePearlIndex: .constant(2))
    }
}
