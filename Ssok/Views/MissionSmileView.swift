//
//  SmileView.swift
//  Ssok
//
//  Created by CHANG JIN LEE on 2023/05/13.
//

import SwiftUI
import RealityKit

struct MissionSmileView : View {
//    @ObservedObject var arViewModel : ARViewModel = ARViewModel()
    @State private var currentTime = Date()
    
    let date = Date()
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    
    @State var isSmile: Bool = false
    @State var isBlink: Bool = false
    
    @State var timeRemaining : Int = 100
    @State var blinkCount: Int = 0
    @State var smileCount: Int = 0
    @State var camerast: Bool = false
    @State var ARstate: String = ""
    @State var CameraState: Bool = false
    @State var sta: Bool = false
    @State private var isLoading = false
    @State var delay: Int = 2
    @State var count: Int = 0
    
    @Environment(\.presentationMode) var mode
    @EnvironmentObject var arViewModel : ARViewModel
    @StateObject var navi = NaviObservableObject()
    
    func viewDidLoad(){
    }
    
    var body: some View {
//        NavigationView{
            ZStack {
                ARViewContainer(arViewModel: arViewModel).edgesIgnoringSafeArea(.all)
                //                    .onDisappear{
                //                        mode.wrappedValue.dismiss()
                //                    }
                VStack {
                    
//                    Button(action: {
//                        // 첫 번째 액션
//                        arViewModel.ARFrame = false
//                    }) {
//                            Text("뒤로 돌아가기")
//                    }
//                    .position(x: wid, y: hei / 5)

                    
                    if ARstate == "smile"
                    {
                        if(!arViewModel.asyncissmileCount){
                            MissionTopView(title: "웃기", description: "웃어요")
//                            Text(arViewModel.isSmiling ? " 웃는중 😄\n \(smileCount) / 2 초\n" + convertSecondsToTime(timeInSeconds:timeRemaining)  : " 웃으세요 😐")
                            Text(arViewModel.isSmiling ? " 웃는중 😄\n \(smCount()) / 3 초\n" : " 웃으세요 😐" + flushCount())
                                .padding()
                                .foregroundColor(arViewModel.isSmiling ? .green : .red)
                                .background(RoundedRectangle(cornerRadius: 20).fill(.thickMaterial))
                                .font(.system(size: 18, weight: .semibold))
                                .position(x: wid / 2 , y: hei / 6)
                        }
                        else{
                            MissionCameraCompleteView(Title: "팀원들웃기기😘", background: Color.mint, CameraState: $CameraState)
                            
                        }
                    } else if ARstate == "blink"{
                        if(!arViewModel.asyncisblinkCount){
                            MissionTopView(title: "윙크", description: "윙크해요")
//                            Text(arViewModel.isBlinking ? " 윙크중 😉\n \(blinkCount) / 2 초\n" +  convertSecondsToTime(timeInSeconds:timeRemaining) : " 윙크하세요 😐")
                            Text(arViewModel.isBlinking ? " 윙크중 😉\n \(smCount()) / 3 초\n" : " 윙크하세요 😐" + flushCount())
                                .padding()
                                .foregroundColor(arViewModel.isBlinking ? .green : .red)
                                .background(RoundedRectangle(cornerRadius: 20).fill(.thickMaterial))
                                .font(.system(size: 18, weight: .semibold))
                                .position(x: wid / 2 , y: hei / 6)
                            
                        }
                        else
                        {
                            MissionCameraCompleteView(Title: "플러팅하기😘", background: Color.mint, CameraState: $CameraState)
                        }
                    }
                    
                }
//                .onAppear {
//                    calcRemain()
//                }
                .onChange(of: arViewModel.isSmiling) { newValue in
                    calcRemain()
                }
                .onChange(of: arViewModel.isBlinking) { newValue in
                    calcRemain()
                }
            }
//        }
//        .navigationBarHidden(true)
    }
    
    
    func smCount() -> String{
//        Thread.sleep(forTimeInterval: 1)
        arViewModel.smileCount += 1
        if(arViewModel.smileCount > 100){
            arViewModel.asyncsmileCount += 1
            arViewModel.smileCount = 0
        }
        if(arViewModel.asyncsmileCount >= 3){
            arViewModel.asyncsmileCount = 3
            arViewModel.asyncissmileCount = true
        }
        return "\(arViewModel.asyncsmileCount)"
    }
    func blCount() -> String{
//        Thread.sleep(forTimeInterval: 1)
        arViewModel.blinkCount += 1
        if(arViewModel.smileCount > 100){
            arViewModel.asyncblinkCount += 1
            arViewModel.blinkCount = 0
        }
        if(arViewModel.asyncblinkCount >= 3){
            arViewModel.asyncblinkCount = 3
            arViewModel.asyncisblinkCount = true
        }
        return "\(arViewModel.asyncsmileCount)"
    }
    
    func flushCount() -> String{
        arViewModel.smileCount = 0
        arViewModel.blinkCount = 0
        return ""
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
    
    func getFormattedTime() -> String {
        updateTime()
        let formatter = DateFormatter()
        formatter.timeStyle = .long
        return formatter.string(from: currentTime)
        }
    
    func updateTime() {
            currentTime = Date()
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

