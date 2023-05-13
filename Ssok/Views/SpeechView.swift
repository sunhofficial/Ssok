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
    var answer = "This is water"
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
                
                if(answer == speechRecognizer.transcript){
                    aaanswer = "미션성공"
                    timer.invalidate()
                }
                else{
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
