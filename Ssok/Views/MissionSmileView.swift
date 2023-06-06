//
//  SmileView.swift
//  Ssok
//
//  Created by CHANG JIN LEE on 2023/05/13.
//

import SwiftUI
import RealityKit

struct MissionSmileView: View {
    @State private var currentTime = Date()

    let date = Date()
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    @State var isSmile: Bool = false
    @State var isBlink: Bool = false
    @State var timeRemaining: Int = 100
    @State var blinkCount: Int = 0
    @State var smileCount: Int = 0
    @State var camerast: Bool = false
    @State var ARstate: String = ""
    @State var cameraState: Bool = false
    @State var smileState: Bool = false
    @State private var isLoading = false
    @State var delay: Int = 2
    @State var count: Int = 0

    @Environment(\.presentationMode) var mode
    @EnvironmentObject var arViewModel: ARViewModel
    @StateObject var navi = NaviObservableObject()

    var body: some View {
            ZStack {
                ARViewContainer(arViewModel: arViewModel)
                    .edgesIgnoringSafeArea(.all)
                VStack {

                    if ARstate == "smile" {
                        if !arViewModel.asyncissmileCount {
                            MissionCameraTopView(title: "얼굴 인식", description: "미션을 성공하려면 얼굴을 인식해야해요.")
                            Text(
                                arViewModel.isSmiling ?
                                "한 번 더 메롱 😝 \(smCount())" : "화면을 보고 혀를 내미세요" + flushCount()
                            )
                            .padding()
                            .foregroundColor(arViewModel.isSmiling ? .green : .red)
                            .background(RoundedRectangle(cornerRadius: 20).fill(.thickMaterial))
                            .font(.system(size: 18, weight: .semibold))
                            .position(x: screenWidth / 2, y: screenHeight / 1.5)
                        } else {
                            MissionCameraCompleteView(title: "혀내밀기 😝",
                                                      background: Color.mint,
                                                      cameraState: $cameraState)
                        }
                    } else if ARstate == "blink"{
                        if !arViewModel.asyncisblinkCount {
                            MissionCameraTopView(title: "얼굴 인식", description: "미션을 성공하려면 얼굴을 인식해야해요.")
                            Text(
                                arViewModel.isBlinking ?
                                "한 번 더 윙크!😜 \(blCount())" : "화면을 보고 윙크하세요" + flushCount()
                            )
                            .padding()
                            .foregroundColor(arViewModel.isBlinking ? .green : .red)
                            .background(RoundedRectangle(cornerRadius: 20).fill(.thickMaterial))
                            .font(.system(size: 18, weight: .semibold))
                            .position(x: screenWidth / 2, y: screenHeight / 1.5)
                        } else {
                            MissionCameraCompleteView(title: "플러팅하기 😘",
                                                      background: Color.mint,
                                                      cameraState: $cameraState)
                        }
                    }
                }
                .onChange(of: arViewModel.isSmiling) { _ in
                    calcRemain()
                }
            }
    }
    func smCount() -> String {
        arViewModel.smileCount += 1
        if arViewModel.smileCount > 30 {
            arViewModel.asyncsmileCount += 1
            arViewModel.smileCount = 0
        }
        if arViewModel.asyncsmileCount >= 2 {
            arViewModel.asyncsmileCount = 2
            arViewModel.asyncissmileCount = true
        }
        return ""
    }
    func blCount() -> String {
        arViewModel.blinkCount += 1
        if arViewModel.blinkCount > 30 {
            arViewModel.asyncblinkCount += 1
            arViewModel.blinkCount = 0
        }
        if arViewModel.asyncblinkCount >= 2 {
            arViewModel.asyncblinkCount = 2
            arViewModel.asyncisblinkCount = true
        }
        return ""
    }

    func flushCount() -> String {
        arViewModel.smileCount = 0
        arViewModel.blinkCount = 0
        return ""
    }

    func convertSecondsToTime(timeInSeconds: Int) -> String {
        let hours = timeInSeconds / 3600
        let minutes = (timeInSeconds - hours*3600) / 60
        let seconds = timeInSeconds % 60
        return String(format: "%02i:%02i:%02i", hours, minutes, seconds)
    }

    func calcRemain() {
        let calendar = Calendar.current
        let targetTime: Date = calendar.date(byAdding: .second,
                                             value: 2,
                                             to: date,
                                             wrappingComponents: false) ?? Date()
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
