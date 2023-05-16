//
//  SmileView.swift
//  Ssok
//
//  Created by CHANG JIN LEE on 2023/05/13.
//

import SwiftUI
import RealityKit

struct MissionSmileView : View {
    @ObservedObject var arViewModel : ARViewModel = ARViewModel()
   
    
    let date = Date()
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    @State var isSmile: Bool = false
    @State var isBlink: Bool = false
    
    @State var timeRemaining : Int = 100
    @State var blinkCount: Int = 0
    @State var ARstate: String = ""
    @State var camerast: Bool = false
    @State var cst: Bool = false
    
    
    @Environment(\.presentationMode) var mode
    @StateObject var navi = NaviObservableObject()
    
    func viewDidLoad(){
        }
    
    var body: some View {
        NavigationView{
            ZStack {
                ARViewContainer(arViewModel: arViewModel).edgesIgnoringSafeArea(.all)
//                    .onDisappear{
//                        mode.wrappedValue.dismiss()
//                    }
                VStack {
                    
                    
                    if ARstate == "smile"
                    {
                        if(!self.isSmile){
                            Text(arViewModel.isSmiling ? "Smiling 😄 " : "Not Smiling 😐")
                                .padding()
                                .foregroundColor(arViewModel.isSmiling ? .green : .red)
                                .background(RoundedRectangle(cornerRadius: 20).fill(.thickMaterial))
                                .onReceive(timer) { _ in
                                    if arViewModel.isSmiling == true{
                                        self.isSmile = true
                                    }
                                }
                        }
                        else{
//                            MissionCompleteView(Title: "팀원들웃기기😘", background: Color.mint)
                            
                        }
                    } else if ARstate == "blink"{
                        if(!self.isBlink){
                            Text(arViewModel.isBlinking ? "Blinking 😉 \(blinkCount) / 5 \n" +  convertSecondsToTime(timeInSeconds:timeRemaining) : "Not Blinking 😐")
                                .padding()
                                .foregroundColor(arViewModel.isBlinking ? .green : .red)
                                .background(RoundedRectangle(cornerRadius: 20).fill(.thickMaterial))
                                .onReceive(timer) { _ in
                                    
                                    if blinkCount >= 5 {
                                        blinkCount = 5
                                        self.isBlink = true
                                    }
                                    if arViewModel.blinkStatus == true{
                                        timeRemaining -= 1
                                    }
                                    if timeRemaining < 0{
                                        timeRemaining = 1
                                        blinkCount += 1
                                    }
                                }
                        }
                        else
                        {
//                            MissionCompleteView(Title: "플러팅하기😘", background: Color.mint)
                        }
                    }
                    
                    Spacer()
                }
                .onAppear {
                    calcRemain()
                }
                .onDisappear{
                    mode.wrappedValue.dismiss()
                    //            }
                }
            }
        }.navigationBarHidden(true)
    }
    
    
    func convertSecondsToTime(timeInSeconds: Int) -> String {
            let hours = timeInSeconds / 3600
            let minutes = (timeInSeconds - hours*3600) / 60
            let seconds = timeInSeconds % 60
            return String(format: "%02i:%02i:%02i", hours,minutes,seconds)
        }
        
        func calcRemain() {
            let calendar = Calendar.current
            let targetTime : Date = calendar.date(byAdding: .second, value: 2, to: date, wrappingComponents: false) ?? Date()
            let remainSeconds = Int(targetTime.timeIntervalSince(date))
            self.timeRemaining = remainSeconds
        }
    
}

struct ARViewContainer: UIViewRepresentable {
    var arViewModel: ARViewModel
    func makeUIView(context: Context) -> ARView {
        arViewModel.startSessionDelegate()
        return arViewModel.arView
    }
    func updateUIView(_ uiView: ARView, context: Context) {}
}
