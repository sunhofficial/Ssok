//
//  SmileView.swift
//  Ssok
//
//  Created by CHANG JIN LEE on 2023/05/13.
//

import SwiftUI
import RealityKit

struct MissionSmileView: View {
    @State var arState = ""
    @Binding var state: Bool

    @Environment(\.presentationMode) var mode
    @ObservedObject var arViewModel = ARViewModel()

    var body: some View {
            ZStack {
                ARViewContainer(arViewModel: arViewModel, state: $state)
                    .edgesIgnoringSafeArea(.all)

                VStack {
                    if arState == "smile" {
                        if !arViewModel.asyncIsSmileCount {
                            MissionTopView(title: "얼굴 인식", description: "미션을 성공하려면 얼굴을 인식해야해요.")
                            Text(
                                arViewModel.isSmiling ?
                                "한 번 더 메롱 😝" + arViewModel.smileCount() : "화면을 보고 혀를 내미세요" + arViewModel.flushCount()
                            )
                            .padding()
                            .foregroundColor(arViewModel.isSmiling ? .green : .red)
                            .background(RoundedRectangle(cornerRadius: 20).fill(.thickMaterial))
                            .font(.system(size: 18, weight: .semibold))
                            .position(x: screenWidth / 2, y: screenHeight / 1.5)
                        } else {
                            MissionCompleteView(title: "혀내밀기 😝",
                                                      background: Color("MissionFace"),
                                                      state: $state)
                        }
                    } else if arState == "blink"{
                        if !arViewModel.asyncIsBlinkCount {
                            MissionTopView(title: "얼굴 인식", description: "미션을 성공하려면 얼굴을 인식해야해요.")
                            Text(
                                arViewModel.isBlinking ?
                                "한 번 더 윙크!😜" + arViewModel.blinkCount() : "화면을 보고 윙크하세요" + arViewModel.flushCount()
                            )
                            .padding()
                            .foregroundColor(arViewModel.isBlinking ? .green : .red)
                            .background(RoundedRectangle(cornerRadius: 20).fill(.thickMaterial))
                            .font(.system(size: 18, weight: .semibold))
                            .position(x: screenWidth / 2, y: screenHeight / 1.5)
                        } else {
                            MissionCompleteView(title: "플러팅하기 😘",
                                                      background: Color("MissionFace"),
                                                      state: $state)
                        }
                    }
                }
            }
    }
}

struct ARViewContainer: UIViewRepresentable {
    var arViewModel: ARViewModel
    @Binding var state: Bool

    func makeUIView(context: Context) -> ARView {
        arViewModel.startSessionDelegate()
        return arViewModel.arView
    }

    func updateUIView(_ uiView: ARView, context: Context) {}
}
