//
//  ContentView.swift
//  PraticeSoundcheck
//
//  Created by 235 on 2023/05/13.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var speechRecognizer = SpeechRecognizer()
    @State var whattosay : String = ""
    var answer = "can i getawater?"
    var timer : Double = 5.0
    @State var aaanswer = "FALESe"
    var body: some View {
        VStack {
            Image(systemName: "mic" )
            Text("아무거나 말해보아요")
            Text(speechRecognizer.transcript).foregroundColor(.red).font(.system(size: 40))
            Text(aaanswer).font(.system(size: 40, weight: .bold))
            
        }
        .padding()
        .onAppear{
            speechRecognizer.stopTranscript() //혹시라도 켜있으면 껏다다시키게
            speechRecognizer.startTranscribing()
            let timer = Timer.scheduledTimer(withTimeInterval: timer, repeats: true){
                timer in
                let cleanedTranscript = speechRecognizer.transcript.replacingOccurrences(of: " ", with: "").replacingOccurrences(of: ",", with: "")
                //영소문자 바꾸는 거 해야함.
              
                if(answer.replacingOccurrences(of: " ", with: "").replacingOccurrences(of: ",", with: "") == cleanedTranscript){
                    aaanswer = "미션성공"
                    timer.invalidate()
                }
                else{ //미션실패면 다시 하도록
                    speechRecognizer.stopTranscript() //혹시라도 켜있으면 껏다다시키게
                    speechRecognizer.startTranscribing()
                }
            }
            RunLoop.main.add(timer, forMode: .common)
            
        }
        .onDisappear{
            speechRecognizer.stopTranscript()
        }
    }
}
