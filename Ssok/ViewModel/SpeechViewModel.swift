////
////  SpeechViewModel.swift
////  Ssok
////
////  Created by 235 on 2023/07/03.
////
//
//import SwiftUI
//class SpeechViewModel: ObservableObject {
//    @Published var isSpeech = true
//    @Published var isWrong = false
//    @Published var isComplete = false
//    @Published var havetext = false
//    @Published var progressTime = 100.0
//    @Published var checkTimer: Timer?
//    private let speechRecognizer = SpeechRecognizer()
//
//    func startCheckTimer(answerText: String) {
//         checkTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] timer in
//             guard let self = self else {
//                 timer.invalidate()
//                 return
//             }
//
//             DispatchQueue.global().async {
//                 let cleanedTranscript = await self.speechRecognizer.transcript.replacingOccurrences(of: " ", with: "").replacingOccurrences(of: ",", with: "")
//
//                 if answerText.replacingOccurrences(of: " ", with: "").replacingOccurrences(of: ",", with: "") == cleanedTranscript {
//                     DispatchQueue.main.async {
//                         timer.invalidate()
//                         self.isComplete = true
//                         await self.speechRecognizer.stopTranscript()
//                     }
//                 } else {
//                     DispatchQueue.main.async {
//                         self.isWrong = true
//                     }
//                 }
//             }
//         }
//     }
//
//       }
