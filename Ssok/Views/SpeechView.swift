//
//  ContentView.swift
//  PraticeSoundcheck
//
//  Created by 235 on 2023/05/13.
//

import SwiftUI

struct SpeechView: View {
    
    @ObservedObject var speechRecognizer = SpeechRecognizer()
    @State var userSay : String = ""
    @State var answerText = "나는 바보다"
    @State var speechTime: Float = 0.0
    
    var answer = "This is water"
    var timer : Double = 5.0
    
    var body: some View {
        VStack(spacing: 40) {
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
                            .minimumScaleFactor(0.1)
                            .lineLimit(1)
                    }
                }
                ZStack {
                    Image("SpeechButton")
                        .shadow(radius: 4, y: 4)
                    VStack(spacing: 25) {
                        Text("말하기")
                            .underline()
                            .foregroundColor(.white)
                            .font(.system(size: 32, weight: .heavy))
                        Text("터치 후 위의 문장을 정확하게 읽어요")
                            .foregroundColor(.white)
                            .font(.system(size: 14, weight: .semibold))
                    }
                    .padding(.top)
                }
            }
            ZStack {
                Image("progress")
                    .tint(Color("Orange_Progress"))
                    .shadow(color: Color(.black).opacity(0.25),radius: 4)
                    .overlay(
                        ProgressView(value: speechTime)
                            .padding(.horizontal, 40)
                            .padding(.top, 8)
                            .scaleEffect(y: 2)
                    )
            }
        }
        //        VStack {
        //            Image(systemName: "mic" )
        //            Text("아무거나 말해보아요")
        //            Text(speechRecognizer.transcript).foregroundColor(.red).font(.system(size: 40))
        //            Text(answerText).font(.system(size: 40, weight: .bold))
        //        }
        .onAppear{
            speechRecognizer.stopTranscript() //혹시라도 켜있으면 껏다다시키게
            speechRecognizer.startTranscribing()
            let timer = Timer.scheduledTimer(withTimeInterval: timer, repeats: true){
                timer in
                let cleanedTranscript = speechRecognizer.transcript.replacingOccurrences(of: " ", with: "").replacingOccurrences(of: ",", with: "")
                //영소문자 바꾸는 거 해야함.
              
                if(answer.replacingOccurrences(of: " ", with: "").replacingOccurrences(of: ",", with: "") != cleanedTranscript){
                    speechRecognizer.stopTranscript() //혹시라도 켜있으면 껏다다시키게
                    speechRecognizer.startTranscribing()
                    print("틀렷으니 다시해라")
                }
            }
            let checktimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true){
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

struct SpeechView_Previews: PreviewProvider {
    static var previews: some View {
        SpeechView()
    }
}
