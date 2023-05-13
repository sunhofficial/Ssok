//
//  StrawView2.swift
//  MC2
//
//  Created by 김용주 on 2023/05/07.
//

import SwiftUI
import CoreMotion
let timer = Timer.publish(every: 0.5, on: .main, in: .common).autoconnect()

struct StrawView: View {
    
    @State var st: Bool = false
    
    let motionmanager = CMMotionManager()
    
    @State var isAnimation: Bool = false
    @State var getFirstBall: Bool = false
    @State var getSecondBall: Bool = false
    @State var getThirdBall: Bool = false
    @State var detec: Int = 0
    @State var gravityx: Double = 0
    @State var progress = 0.0
    @State var Where: String = "\(whereList[Int.random(in:0..<whereList.count)])"
    @State var What: String = "\(whatList[Int.random(in:0..<whatList.count)])"
     
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    @EnvironmentObject var random: RandomMember
     
    var body: some View {
        if !st{
            ZStack{
                ZStack {
                    Rectangle().fill(LinearGradient(gradient: Gradient(colors: [ Color("Bg_top"), Color("Bg_center"), Color("Bg_bottom2")]), startPoint: .top, endPoint: .bottom)).ignoresSafeArea()
                    
                    if detec < 50 {
                        Image("firstdrink").position(CGPoint(x:wid/2, y: 552.5))
                    } else {
                        Image("finaldrink").position(CGPoint(x:wid/2, y: 552.5))
                    }
                    
                    BottleView()
                    if detec >= 50 {
                        Image("Straw").opacity(0.8).offset(y:20)
                        //                        .transition(.move(edge: .bottom))
                            .offset(y: isAnimation ? hei/2-425 : -hei+345)
                            .animation(.easeInOut(duration: 1).delay(0.5), value: isAnimation)
                    }
                    VStack(spacing: 24) {
                        // 가이드
                        
                        VStack(spacing: 24) {
                            if detec >= 50 {
                                // 흔들기 완료 후 여기
                                Image("PutStrawIcon")
                                    .padding(.top, 100)
                                Text("빨대를 꼽고 펄을 뽑아주세요")
                                    .foregroundColor(.white)
                                    .font(.system(size: 24, weight: .bold))
                                    .multilineTextAlignment(.center)
                                    .lineSpacing(4)
                                    .padding(.top, -10)
                            } else {
                                // 초기화면
                                Image("ShakeIcon")
                                    .padding(.bottom, -10)
                                    .rotationEffect(Angle(degrees: 10.21))
                                Text("버블티를 흔들어주세요!")
                                    .foregroundColor(.white)
                                    .font(.system(size: 24, weight: .bold))
                                
                                Text("팀원들, 장소 그리고 벌칙들이\n섞이는 중이에요")
                                    .multilineTextAlignment(.center)
                                    .foregroundColor(.white)
                                    .font(.system(size: 15, weight: .semibold))
                                    .padding(.top, -10)
                                
                                ProgressView(value: progress)
                                    .tint(Color("Bg_bottom2"))
                                    .background(.white)
                                    .cornerRadius(8)
                                    .scaleEffect(x: 1, y: 2)
                                    .padding([.leading, .trailing], 85)
                                
                                Button {
                                    detec = 50
                                } label: {
                                    Text("바로 빨대꼽기")
                                        .foregroundColor(.white)
                                        .font(.system(size: 13, weight: .bold))
                                        .underline(true, color: .white)
                                }
                            }
                        }
                        .opacity(isAnimation ? 0 : 1)
                        // 컵 & 버블
                        ZStack {
                            // 버블
                            VStack {
                                Spacer()
                                Image("Pearl1")
                                    .animation(.easeOut(duration: 1.5).delay(1.2),value: isAnimation)

                                Image("Pearl2")
                                    .animation(.easeOut(duration: 1.5).delay(1.4),value: isAnimation)

                                Image("Pearl1")
                                    .animation(.easeOut(duration: 1.5).delay(1.6),value: isAnimation)
                            }
                            .frame(width: 28)
                            .opacity(isAnimation ? 1 : 0)
                            .offset(y: isAnimation ? -hei+20 : 20)
                            .animation(.easeInOut.delay(1.5), value: isAnimation)
                        }
                        .frame(width: UIScreen.main.bounds.width / 1.3, height:UIScreen.main.bounds.height / 1.8)
                    }
                    // 빨대
//                    if isAnimation {
                    
//                    Image("Straw").opacity(0.8).offset(y:20)
////                        .transition(.move(edge: .bottom))
//                        .offset(y: isAnimation ? hei/2-425 : -hei+345)
//                        .animation(.easeInOut(duration: 1).delay(0.5), value: isAnimation)
//                    }
                    Image("cutcup").position(x: wid/2 ,y:374.05)

//                    Image("cutdrinks").position(x: wid/2, y: 534.6).opacity(0.4)
                    //Dim
                    Color(.white)
                        .edgesIgnoringSafeArea(.all)
                        .opacity(isAnimation ? 0.5 : 0)
                        .animation(.easeInOut(duration: 1).delay(2.5), value: isAnimation)

                    //  첫 번째 볼
                    BallView(
                        getCurrentBall: $getFirstBall,
                        getNextBall: $getSecondBall,
                        ballTitle: "Who?",
                        contents: random.randomMemberName,
                        pearlImage: "Back_pearl1",
                        c0x: 0.25,
                        c0y: 0,
                        c1x: 0.75,
                        c1y: 1,
                        duration: 1
                    )

                    // 두 번째 볼
                    BallView(
                        getCurrentBall: $getSecondBall,
                        getNextBall: $getThirdBall,
                        ballTitle: "Where?",
                        contents: Where,
                        pearlImage: "Back_pearl2",
                        c0x: 0,
                        c0y: 1,
                        c1x: 1,
                        c1y: 0,
                        duration: 2
                    )

                    // 세 번째 볼
                    BallView(
                        getCurrentBall: $getThirdBall,
                        getNextBall: $getThirdBall,
                        ballTitle: "What?",
                        contents: What,
                        pearlImage: "Back_pearl1",
                        c0x: 0,
                        c0y: 1,
                        c1x: 1,
                        c1y: 0,
                        duration: 2
                    )
                }
                .onTapGesture {
                    if detec >= 50{
                        withAnimation(.easeInOut(duration: 1)) {
                            isAnimation = true
                        }
                        withAnimation(.timingCurve(0.25, 0, 0.75, 1, duration: 1).delay(3)) {
                            getFirstBall = true
                        }
                    }

                }
                .navigationBarBackButtonHidden()
                .navigationBarItems(leading: backButton)

                if getThirdBall == true{
                    Button(action: {st = true}) {
                        Rectangle().fill(.opacity(0))
                    }.scaledToFit()
                }
            }.onReceive(timer) { input in
                
                if motionmanager.isDeviceMotionAvailable {
                    motionmanager.deviceMotionUpdateInterval = 0.2
                    motionmanager.startDeviceMotionUpdates(to: OperationQueue.main) { data,error in
                        gravityx = data?.gravity.x ?? 0
                        if gravityx > 0.3 || gravityx < -0.3 {
                            if detec != 50 {
                                detec += 1
                                print(detec)
                                progress += 0.02
                                print(progress)
                            }
                        }
                    }
                }
            }
            .offset(y: -44)
        }else {
            EndingView(wheresentence : Where, whatsentence : What)
        }
    }
}

extension StrawView {
    
    var backButton: some View {
        Button {
            mode.wrappedValue.dismiss()
        } label: {
            Image(systemName: "chevron.backward")
                .foregroundColor(.white)
                .bold()
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
