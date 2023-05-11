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
                        Image("firstdrink").position(CGPoint(x:wid/2, y: 532.5))
                    } else {
                        Image("finaldrink").position(CGPoint(x:wid/2, y: 532.5))
                    }
                    
                    BottleView()
                    VStack(spacing: 24) {
                        // 가이드
                        VStack(spacing: 24) {
                            if count >= 2 {
                                Text("빨대를 꼽고 펄을 뽑아주세요")
                                    .foregroundColor(.white)
                                    .font(.system(size: 24, weight: .bold))
                                    .multilineTextAlignment(.center)
                                    .lineSpacing(4)
                                Image(systemName: "arrow.down")
                                    .resizable()
                                    .bold()
                                    .foregroundColor(.white)
                                    .frame(width: 24, height: 24)
                            } else {
                                Text("컵을 흔들어서 버블티를 섞어주세요")
                                    .foregroundColor(.white)
                                    .font(.system(size: 24, weight: .bold))
                                    .multilineTextAlignment(.center)
                                    .lineSpacing(4)
                                Image("shakearrow")
                                    .resizable()
                                    .bold()
                                    .foregroundColor(.white)
                                    .frame(width: 73, height: 18)
                                    
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
                            .offset(y: isAnimation ? -UIScreen.main.bounds.height : 0)
                            .animation(.easeInOut.delay(0.5), value: isAnimation)
                        }
                        .frame(width: UIScreen.main.bounds.width / 1.3, height:UIScreen.main.bounds.height / 1.8)
                    }
                    // 빨대
                    if isAnimation {

                        Image("Straw").opacity(0.8).transition(.move(edge: .top))
                    }
                    Image("cutcup").position(x: wid/2 ,y:349.05)

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
                    if count >= 2{
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
            }.onShake {
                count += 1
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
