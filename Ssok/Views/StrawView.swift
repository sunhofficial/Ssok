//
//  StrawView2.swift
//  MC2
//
//  Created by 김용주 on 2023/05/07.
//

import SwiftUI
import CoreMotion


struct StrawView: View {
    
    let motionmanager = CMMotionManager()
    @StateObject private var viewModel = StrawViewModel()
    @State var st: Bool = false
    @State var isAnimation: Bool = false
    @State var isDisplay: Bool = false
    @State var getFirstBall: Bool = false
    @State var getSecondBall: Bool = false
    @State var getThirdBall: Bool = false
    @State var dragAmount: CGSize = CGSize.zero
    @State var isPlug: Bool = false
    @State var previousview: Bool = false
    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    @EnvironmentObject var random: RandomMember
    
    
    var body: some View {
        if !st{
            ZStack {
                LinearGradient(gradient: Gradient(colors: [ Color("Bg_top"), Color("Bg_center"), Color("Bg_bottom2")]), startPoint: .top, endPoint: .bottom).ignoresSafeArea()
                
                if viewModel.maxProgress != 1 {
                    Image("firstdrink").position(CGPoint(x:wid/2, y: 552.5))
                } else {
                    Image("finaldrink").position(CGPoint(x:wid/2, y: 552.5))
                }
                
                
                BottleView()
                
                
                VStack(spacing: 24) {
                    // 가이드
                    VStack(spacing: 24) {
                        if viewModel.maxProgress == 1 {
                            // 흔들기 완료 후 여기
                            ZStack {
                                WhiteRectangleView()
                                    .frame(width: 300, height: 106)
                                    .padding(.top, 100)
                                VStack {
                                    ZStack {
                                        Image("PhoneIcon")
                                            .padding(.top, 50)
                                        Image("HandIcon")
                                            .padding(.top, 70)
                                            .padding(.leading, 30)
                                    }
                                    Text("스트로우를 꼽아주세요!")
                                        .font(.system(size: 18, weight: .bold))
                                        .padding(.bottom, 1)
                                    Text("스트로우를 꼽으면 벌칙이 담긴 펄이 올라와요")
                                        .font(.system(size: 13, weight: .semibold))
                                }
                            }
                        } else {
                            ZStack {
                                WhiteRectangleView()
                                    .frame(width: 300, height: 153)
                                VStack {
                                    Image("ShakeIcon")
                                        .padding(.top, -60)
                                        .padding(.bottom, 0)
                                    Text("버블티를 흔들어주세요!")
                                        .font(.system(size: 18, weight: .bold))
                                        .padding(.bottom, 5)
                                    Text("팀원들, 장소 그리고 미션들이\n섞이는 중이에요")
                                        .multilineTextAlignment(.center)
                                        .font(.system(size: 13, weight: .semibold))
                                        .padding(.bottom, 10)
                                    ProgressView(value: viewModel.maxProgress)
                                        .tint(Color("Orange_Progress"))
                                        .background(Color("LightGray"))
                                        .frame(width: 240, height: 8)
                                        .scaleEffect(x: 1, y: 2)
                                        .clipShape(RoundedRectangle(cornerRadius: 4))
                                }
                            }
                            .padding(.top, 30)
                        }
                    }
                    .opacity(isDisplay ? 0 : 1)
                    // 컵 & 버블
                    ZStack {
                        // 버블
                        VStack {
                            Spacer()
                            Image("Pearl1")
                                .animation(.easeOut(duration: 1.5).delay(1.4),value: isAnimation)
                            
                            Image("Pearl2")
                                .animation(.easeOut(duration: 1.5).delay(1.6),value: isAnimation)
                            
                            Image("Pearl1")
                                .animation(.easeOut(duration: 1.5).delay(1.8),value: isAnimation)
                        }
                        .frame(width: 28)
                        .opacity(isAnimation ? 1 : 0)
                        .offset(y: isAnimation ? -hei : -10)
                        .animation(.easeInOut.delay(1), value: isAnimation)
                    }
                    .frame(width: UIScreen.main.bounds.width / 1.3, height:UIScreen.main.bounds.height / 1.8)
                }
                
                // 빨대
                if viewModel.maxProgress == 1 {
                    Image("Straw")
                        .frame(width: 200)
                        .contentShape(Rectangle())
                        .opacity(0.8)
                        .animation(.easeInOut(duration: 1), value: isAnimation)
                        .offset(y: isAnimation ? 0 : dragAmount.height - hei/1.7)
                        .gesture(
                            DragGesture()
                                .onChanged { gesture in
                                    if gesture.translation.height > 0 && gesture.translation.height < 240 {
                                        dragAmount = CGSize(width: 0, height: gesture.translation.height)
                                        withAnimation(.easeInOut) {
                                            isDisplay = true
                                        }
                                    }
                                    isPlug = gesture.translation.height > 150
                                    
                                }
                                .onEnded { _ in
                                    if isPlug {
                                        withAnimation(.easeInOut(duration: 1)) {
                                            isAnimation = true
                                        }
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.7) {
                                            HapticManager.instance.impact(style: .heavy)
                                            HapticManager.instance.impact(style: .heavy)
                                        }
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.9) {
                                            HapticManager.instance.impact(style: .heavy)
                                            HapticManager.instance.impact(style: .heavy)
                                        }
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 2.1) {
                                            HapticManager.instance.impact(style: .heavy)
                                            HapticManager.instance.impact(style: .heavy)
                                        }
                                        withAnimation(.easeInOut(duration: 1).delay(3)) {
                                            getFirstBall = true
                                        }
                                    } else {
                                        withAnimation(.easeInOut) {
                                            isDisplay = false
                                        }
                                    }
                                    dragAmount = .zero
                                    isPlug = false
                                }
                        )
                        .animation(.spring(), value: dragAmount)
                    Image("cutcup").position(x: wid/2 ,y:377)
                }
                
                //Dim
                Color(.white)
                    .edgesIgnoringSafeArea(.all)
                    .opacity(isAnimation ? 0.5 : 0)
                    .animation(.easeInOut(duration: 1).delay(2.5), value: isAnimation)
                
                //  첫 번째 볼
                BallView(
                    getCurrentBall: $getFirstBall,
                    getNextBall: $getSecondBall,
                    st: $st,
                    stBool: false,
                    ballTitle: "Who?",
                    contents: random.randomWho,
                    pearlImage: "Back_pearl1"
                )
                
                // 두 번째 볼
                BallView(
                    getCurrentBall: $getSecondBall,
                    getNextBall: $getThirdBall,
                    st: $st,
                    stBool: false,
                    ballTitle: "Where?",
                    contents: random.randomWhere,
                    pearlImage: "Back_pearl2"
                )
                
                // 세 번째 볼
                BallView(
                    getCurrentBall: $getThirdBall,
                    getNextBall: $getThirdBall,
                    st: $st,
                    stBool: true,
                    ballTitle: "What?",
                    contents: String(random.randomWhat.missionTitle.dropLast(2)),
                    pearlImage: "Back_pearl1"
                )
                HStack {
                    VStack {
                        backButton
                        Spacer()
                    }
                    Spacer()
                }
                .padding(.leading, 8)
                .padding(.top, 48)
                
            }.navigationBarHidden(true)
            .onAppear{
                viewModel.startupdatingMotion()
            }
            .onDisappear{
                isAnimation = false
                isDisplay = false
                getFirstBall = false
                getSecondBall = false
                getThirdBall = false
                viewModel.progress = 0.0
            }
            
        } else {
            switch random.randomWhat.missionType {
            case .decibel:
                DecibelEndingView(state: $st, wheresentence: random.randomWhere, whatsentence: String(random.randomWhat.missionTitle.dropLast(2)), missionTitle: random.randomWhat.missionTitle, missionTip: random.randomWhat.missionTip, missionColor: random.randomWhat.missionColor, goal: random.randomWhat.goal!)
            case .shake:
                CountEndingView(wheresentence: random.randomWhere ,whatsentence: String(random.randomWhat.missionTitle.dropLast(2)), missionTitle: random.randomWhat.missionTitle, missionTip: random.randomWhat.missionTip, missionColor: random.randomWhat.missionColor, GoalCount: random.randomWhat.goal!, st: $st)
            case .voice:
                SpeakEndingView(wheresentence: random.randomWhere, whatsentence: String(random.randomWhat.missionTitle.dropLast(2)), missionTitle: random.randomWhat.missionTitle, missionTip: random.randomWhat.missionTip, missionColor: random.randomWhat.missionColor, goal: random.randomWhat.goal!, timer: Double(random.randomWhat.timer!), st: $st)
            case .smile:
                CameraEndingView(wheresentence: random.randomWhere, whatsentence: String(random.randomWhat.missionTitle.dropLast(2)), missionTitle: random.randomWhat.missionTitle, missionTip: random.randomWhat.missionTip, missionColor: random.randomWhat.missionColor, st: $st, arstate: "smile")
            case .blink:
                CameraEndingView(wheresentence: random.randomWhere,whatsentence: String(random.randomWhat.missionTitle.dropLast(2)), missionTitle: random.randomWhat.missionTitle, missionTip: random.randomWhat.missionTip, missionColor: random.randomWhat.missionColor, st: $st, arstate: "blink")
            }
        }
    }
}

extension StrawView {
    var backButton: some View {
        Button {
            mode.wrappedValue.dismiss()
        } label: {
            ZStack {
                Rectangle()
                    .frame(width: 40, height: 40)
                    .foregroundColor(.clear)
                Image(systemName: "chevron.backward")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 20, height: 20)
                    .foregroundColor(.white)
                    .bold()
            }
        }
    }
    
}

struct StrawView_Previews: PreviewProvider {
    static let random = RandomMember()
    static var previews: some View {
        StrawView()
            .environmentObject(random)
    }
}
