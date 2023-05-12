//
//  StrawView2.swift
//  MC2
//
//  Created by 김용주 on 2023/05/07.
//

import SwiftUI

// The notification we'll send when a shake gesture happens.
extension UIDevice {
    static let deviceDidShakeNotification = Notification.Name(rawValue: "deviceDidShakeNotification")
}

//  Override the default behavior of shake gestures to send our notification instead.
extension UIWindow {
     open override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            NotificationCenter.default.post(name: UIDevice.deviceDidShakeNotification, object: nil)
        }
     }
}

// A view modifier that detects shaking and calls a function of our choosing.
struct DeviceShakeViewModifier: ViewModifier {
    let action: () -> Void

    func body(content: Content) -> some View {
        content
            .onAppear()
            .onReceive(NotificationCenter.default.publisher(for: UIDevice.deviceDidShakeNotification)) { _ in
                action()
            }
    }
}

// A View extension to make the modifier easier to use.
extension View {
    func onShake(perform action: @escaping () -> Void) -> some View {
        self.modifier(DeviceShakeViewModifier(action: action))
    }
}


struct StrawView: View {
    
    @State var st: Bool = false
    
    @State var isAnimation: Bool = false
    @State var getFirstBall: Bool = false
    @State var getSecondBall: Bool = false
    @State var getThirdBall: Bool = false
    @State var count: Int = 0
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
                    
                    if count < 2 {
                        Image("firstdrink").position(CGPoint(x:wid/2, y: 552.5))
                    } else {
                        Image("finaldrink").position(CGPoint(x:wid/2, y: 552.5))
                    }
                    
                    BottleView()
                    if count > 2 {
                        Image("Straw").opacity(0.8).offset(y:20)
                        //                        .transition(.move(edge: .bottom))
                            .offset(y: isAnimation ? hei/2-425 : -hei+345)
                            .animation(.easeInOut(duration: 1).delay(0.5), value: isAnimation)
                    }
                    VStack(spacing: 24) {
                        // 가이드
                        
                        VStack(spacing: 24) {
                            if count >= 3 {
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
                                    count = 3
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
                        pearlImage: "Back_pearl1"
                    )

                    // 두 번째 볼
                    BallView(
                        getCurrentBall: $getSecondBall,
                        getNextBall: $getThirdBall,
                        ballTitle: "Where?",
                        contents: Where,
                        pearlImage: "Back_pearl2"
                    )

                    // 세 번째 볼
                    BallView(
                        getCurrentBall: $getThirdBall,
                        getNextBall: $getThirdBall,
                        ballTitle: "What?",
                        contents: What,
                        pearlImage: "Back_pearl1"
                    )
                }
                .onTapGesture {
                    if count >= 2{
                        withAnimation(.easeInOut(duration: 1)) {
                            isAnimation = true
                        }
                        withAnimation(.easeInOut(duration: 1).delay(3)) {
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
            }
            .onShake {
                count += 1
                progress += 0.334
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
