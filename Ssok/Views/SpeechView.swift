//
//  ContentView.swift
//  PraticeSoundcheck
//
//  Created by 235 on 2023/05/13.
//

import SwiftUI

struct SpeechView: View {
    
    @ObservedObject var speechRecognizer = SpeechRecognizer()
    @State var answerText = "나는 바보다"
    @State var speechTime: Double = 0.0
    @State var isSpeech: Bool = false
    @State var isWrong: Bool = false
    
    let progressTimer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var answer = "This is water"
    var timer : Double = 5.0
    
    var body: some View {
        VStack(spacing: 24) {
            ZStack(alignment: .top) {
                Image("speech_top")
                    .edgesIgnoringSafeArea(.all)
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("따라읽기")
                            .font(.system(size: 24, weight: .heavy))
                        Text("주어진 문장을 정확하게 따라 읽어서 인식시켜요")
                            .font(.system(size: 13, weight: .semibold))
                    }
                    .foregroundColor(.white)
                    Spacer()
                    ZStack {
                        Circle()
                            .frame(width: 50, height: 50)
                            .foregroundColor(.white)
                        Text("📖")
                            .font(.system(size: 24, weight: .heavy))
                    }
                }
                .padding(.horizontal, 20)
                .padding(.top, 20)
            }
            Text("바보 되기 🤪")
                .font(.system(size: 20, weight: .semibold))
                .padding(.horizontal, 10)
                .padding(.vertical, 6)
                .background(
                    Color("LightBlue_fill")
                        .cornerRadius(15)
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(Color("LightBlue_stroke"), lineWidth: 1.5)
                )
            VStack(spacing: 30) {
                ZStack {
                    RoundedRectangle(cornerRadius: 20)
                        .frame(width: 307, height: 175)
                        .foregroundColor(.white)
                        .shadow(radius: 10)
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .frame(width: 284, height: 175)
                                .foregroundColor(.white)
                                .shadow(radius: 10)
                                .offset(y: 12)
                                .background(
                                    RoundedRectangle(cornerRadius: 20)
                                        .frame(width: 268, height: 175)
                                        .foregroundColor(.white)
                                        .shadow(radius: 10)
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
                if !isSpeech {
                    ZStack {
                        Image("SpeechButton")
                            .shadow(radius: 4, y: 4)
                        VStack(spacing: 24) {
                            Text("눌러서 말하기")
                                .underline()
                                .foregroundColor(.white)
                                .font(.system(size: 32, weight: .heavy))
                            Text(isWrong ? "제시어와 달라요 다시 읽어 주세요" : "터치 후 위의 문장을 정확하게 읽어요")
                                .foregroundColor(.white)
                                .font(.system(size: 14, weight: .semibold))
                        }
                        .padding(.top)
                    }
                    .onTapGesture {
                        speechTime = 100
                        isSpeech = true
                    }
                } else {
                    ZStack {
                        Image("Speeching")
                            .shadow(color: Color("Orange").opacity(0.5), radius: 5)
                        VStack(spacing: 16) {
                            Text("내 발음")
                                .font(.system(size: 13, weight: .semibold))
                                .padding(.horizontal, 9)
                                .padding(.vertical, 4)
                                .background(Color("Orange"))
                                .cornerRadius(15)
                                .foregroundColor(.white)
                            if speechRecognizer.transcript == "" {
                                Text("제시어를 읽어주세요")
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
                    .onAppear {
                        speechRecognizer.stopTranscript() //혹시라도 켜있으면 껏다다시키게
                        speechRecognizer.startTranscribing()
                        let timer = Timer.scheduledTimer(withTimeInterval: timer, repeats: false){
                            timer in
                            let cleanedTranscript = speechRecognizer.transcript.replacingOccurrences(of: " ", with: "").replacingOccurrences(of: ",", with: "")
                            //영소문자 바꾸는 거 해야함.
                            
                            if(answer.replacingOccurrences(of: " ", with: "").replacingOccurrences(of: ",", with: "") != cleanedTranscript){
                                speechRecognizer.stopTranscript() //혹시라도 켜있으면 껏다다시키게
                                speechRecognizer.startTranscribing()
                                isWrong = true
                                isSpeech = false
                                speechRecognizer.transcript = ""
                            }
                        }
                        let checktimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false){
                            timer in
                            let cleanedTranscript = speechRecognizer.transcript.replacingOccurrences(of: " ", with: "").replacingOccurrences(of: ",", with: "")
                            //영소문자 바꾸는 거 해야함.

                            if(answer.replacingOccurrences(of: " ", with: "").replacingOccurrences(of: ",", with: "") == cleanedTranscript){
                                timer.invalidate()
                                print("끝이 났어요")
                            }}
                        RunLoop.main.add(checktimer, forMode: .common)
                        RunLoop.main.add(timer, forMode: .common)
                    }
                    .onDisappear{
                        speechRecognizer.stopTranscript()
                    }
                }
            }
            Image("progress")
                .shadow(color: Color(.black).opacity(0.25),radius: 4)
                .overlay(
                    ProgressView(value: speechTime, total: 100)
                        .tint(Color("Orange_Progress"))
                        .padding(.horizontal, 40)
                        .padding(.top, 8)
                        .scaleEffect(y: 2)
                        .onReceive(progressTimer) { _ in
                            withAnimation(.linear(duration: 1)) {
                                if speechTime > 0 {
                                    speechTime -= 100/timer
                                }
                            }
                        }
                )
        }
    }
}

struct SpeechView_Previews: PreviewProvider {
    static var previews: some View {
        SpeechView()
    }
}
