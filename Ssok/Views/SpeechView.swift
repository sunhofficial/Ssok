//
//  ContentView.swift
//  PraticeSoundcheck
//
//  Created by 235 on 2023/05/13.
//

import SwiftUI

struct SpeechView: View {
    @ObservedObject var speechRecognizer = SpeechRecognizer()
    @State var whattosay : String = ""
    var answer = "This is water"
    @State var aaanswer = "FALESe"
    var body: some View {
        VStack {
            Image(systemName: "mic" )
            Text("아무거나 말해보아요")
            Text(speechRecognizer.transcript).foregroundColor(.red).font(.system(size: 40))
            Text(aaanswer).font(.system(size: 40, weight: .bold))
            
        }
        .padding()
//        .onReceive(speechRecognizer.transcript, perform: {
//            newthing in
//            whattosay = newthing
//        })
        .onAppear{
            speechRecognizer.resetTranscript()
            speechRecognizer.startTranscribing()
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 10) {
                if(answer == speechRecognizer.transcript){
                    aaanswer = "미션성공"
                }
                speechRecognizer.stopTranscribing()
                
                
                     }
//            isRecording = true
     
        }
        
        .onDisappear{
            
//            isRecording = false
        }
       
      
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
