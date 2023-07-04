//
//  StrawView2.swift
//  MC2
//
//  Created by 김용주 on 2023/05/07.
//

import SwiftUI
import SpriteKit

struct StrawView: View {
    @StateObject private var viewModel = StrawViewModel()
    @State private var goNextView = false
    @State private var moveStraw = false
    @State private var largePearlIndex = -1
    @State private var dragAmount = CGSize.zero
    @State private var isPlug = false
    var scene = Bottle(size: CGSize(width: 390, height: 844))
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @EnvironmentObject var random: RandomMember
    @Binding var path: NavigationPath
    private var pearlContents : [[String]] {
        [
            ["Who?",random.randomWho, "imgBackPearl1" ],
            ["Where?", random.randomWhere, "imgBackPearl2"],
            ["What?",String(random.randomWhat.missionInfo.missionTitle.dropLast(2)),"imgBackPearl1" ]
        ]}
    
    var body: some View {
        if !goNextView {
            ZStack {
                LinearGradient(gradient:
                                Gradient(colors: [ Color("Bg_top"), Color("Bg_center"), Color("Bg_bottom2")]),
                               startPoint: .top, endPoint: .bottom).ignoresSafeArea()
                
                Image(viewModel.maxProgress == 1 ? "imgFinalDrink" : "imgFirstDrink")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(.top, UIScreen.getHeight(323))
                    .padding(.bottom, UIScreen.getHeight(57))
                
                SpriteView(
                    scene: scene,
                    options: [.allowsTransparency],
                    shouldRender: {_ in return true}
                )
                .aspectRatio(0.5, contentMode: .fit)
                .padding(
                    .bottom,
                    (UIScreen.screenHeight >= 844)&&(UIScreen.screenHeight<=932) ? 0 : UIScreen.getHeight(30))
                
                Image("imgCupHead")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: UIScreen.getHeight(102))
                    .padding(.top, UIScreen.getHeight(323))
                    .padding(.bottom, UIScreen.getHeight(419))
                
                ZStack {
                    WhiteRectangleView()
                        .frame(
                            width: UIScreen.getWidth(300),
                            height: viewModel.maxProgress == 1 ?
                            UIScreen.getHeight(106) : UIScreen.getHeight(153)
                        )
                    if viewModel.maxProgress == 1 {
                        VStack {
                            ZStack {
                                Image("imgPhoneIcon")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: UIScreen.getWidth(58), height: UIScreen.getHeight(79))
                                    .padding(.top, UIScreen.getHeight(-60))
                                Image("imgHandIcon")
                                    .padding(.top, UIScreen.getHeight(-47))
                                    .padding(.leading, UIScreen.getWidth(30))
                            }
                            Text("스트로우를 꼽아주세요!")
                                .font(Font.custom18bold())
                                .padding(.bottom, UIScreen.getHeight(1))
                            Text("스트로우를 꼽으면 벌칙이 담긴 펄이 올라와요")
                                .font(Font.custom13semibold())
                        }
                    } else {
                        VStack {
                            Image("imgShakeIcon")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: UIScreen.getWidth(58), height: UIScreen.getHeight(79))
                                .padding(.top, UIScreen.getHeight(-60))
                            Text("버블티를 흔들어주세요!")
                                .font(Font.custom18bold())
                                .padding(.bottom, UIScreen.getHeight(5))
                            Text("팀원들, 장소 그리고 미션들이\n섞이는 중이에요")
                                .multilineTextAlignment(.center)
                                .font(Font.custom13semibold())
                                .padding(.bottom, UIScreen.getHeight(10))
                            ProgressView(value: viewModel.maxProgress)
                                .tint(Color("Orange_Progress"))
                                .background(Color("LightGray"))
                                .frame(width: UIScreen.getWidth(240), height: UIScreen.getHeight(8))
                                .scaleEffect(x: 1, y: 2)
                                .clipShape(RoundedRectangle(cornerRadius: 4))
                        }
                    }
                }
                .offset(y: viewModel.maxProgress == 1 ?
                        UIScreen.getHeight(-185) : UIScreen.getHeight(-225))
                .opacity(viewModel.showWhiteRectangle ? 1 : 0)
                
                ZStack {
                    VStack {
                        Spacer()
                        ForEach(0..<3) { index in
                            Image(index % 2 == 0 ? "imgPearl1" : "imgPearl2")
                                .animation(.easeOut(duration: 1.5)
                                    .delay(1.4 + Double(index) * 0.2), value: moveStraw)
                        }
                    }
                    .frame(width: UIScreen.getWidth(28))
                    .opacity(moveStraw ? 1 : 0)
                    .offset(y: moveStraw ? -UIScreen.screenHeight : -10)
                    .animation(.easeInOut.delay(1), value: moveStraw)
                }
                .frame(width: UIScreen.getWidth(300), height: UIScreen.getHeight(469))
                // 빨대
                if viewModel.maxProgress == 1 {
                    Image("imgStraw")
                        .frame(width: UIScreen.getWidth(200))
                        .contentShape(Rectangle())
                        .opacity(0.8)
                        .animation(.easeInOut(duration: 1), value: moveStraw)
                        .offset(y: moveStraw ? 0 : dragAmount.height - UIScreen.getHeight(496.5))
                        .gesture(
                            DragGesture()
                                .onChanged { gesture in
                                    if gesture.translation.height > 0
                                        && gesture.translation.height < UIScreen.getHeight(240) {
                                        dragAmount = CGSize(width: 0, height: gesture.translation.height)
                                        withAnimation(.easeInOut) {
                                            viewModel.showWhiteRectangle = false
                                        }
                                    }
                                    isPlug = gesture.translation.height > UIScreen.getHeight(150)
                                }
                                .onEnded { _ in
                                    if isPlug {
                                        withAnimation(.easeInOut(duration: 1)) {
                                            moveStraw = true
                                        }
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.7) {
                                            viewModel.uppearlVibration()
                                        }
                                        withAnimation(.easeInOut(duration: 1).delay(3)) {
                                            largePearlIndex = 0
                                        }
                                    } else {
                                        withAnimation(.easeInOut) {
                                            viewModel.showWhiteRectangle = true
                                        }
                                    }
                                    dragAmount = .zero
                                    isPlug = false
                                }
                        )
                        .animation(.spring(), value: dragAmount)
                    Image("imgCutCup")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: UIScreen.getHeight(102))
                        .padding(.top, UIScreen.getHeight(323))
                        .padding(.bottom, UIScreen.getHeight(419))
                }
                
                if largePearlIndex >= 0 {
                    Color(.white)
                        .edgesIgnoringSafeArea(.all)
                        .opacity(0.5)
                        .onTapGesture {
                            largePearlIndex += 1
                        }
                    BallView(getCurrentPearl: $largePearlIndex,
                             state: $goNextView, pearlContents: pearlContents)
                }
                HStack {
                    VStack {
                        backButton
                        Spacer()
                    }
                    Spacer()
                }
                .padding(.leading, UIScreen.getWidth(8))
                .padding(.top, UIScreen.getHeight(48))
            }
            .navigationBarHidden(true)
            .onAppear {
                moveStraw = false
                viewModel.showWhiteRectangle = true
                viewModel.startupdatingMotion()
            }
        } else {
            MissionEndingView(state: $goNextView,
                              missionTitle: random.randomWhat.missionInfo.missionTitle,
                              missionTip: random.randomWhat.missionInfo.missionTip,
                              largePearlIndex: $largePearlIndex)
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
                    .frame(width: 25, height: 25)
                    .foregroundColor(.white)
                    .bold()
            }
        }
    }
}

struct StrawView_Previews: PreviewProvider {
    static var previews: some View {
        StrawView(path: .constant(NavigationPath()))
            .environmentObject(RandomMember())
    }
}
