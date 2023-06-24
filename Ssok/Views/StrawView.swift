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
    var scene = Bottle(size: CGSize(width: screenWidth, height: screenHeight))
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @EnvironmentObject var random: RandomMember
    @Binding var path: NavigationPath
    private var pearlContents : [[String]] {
        [
        ["Who?",random.randomWho, "imgBackPearl1" ],
        ["Where?", random.randomWhere, "imgBackPearl2"],
        ["What?",String(random.randomWhat.missionDetail.missionTitle.dropLast(2)),"imgBackPearl1" ]
        ]}

    var body: some View {
        if !goNextView {
            ZStack {
                LinearGradient(gradient:
                                Gradient(colors: [ Color("Bg_top"), Color("Bg_center"), Color("Bg_bottom2")]),
                               startPoint: .top, endPoint: .bottom).ignoresSafeArea()
                    Image(viewModel.maxProgress != 1 ? "imgFirstDrink" : "imgFinalDrink")
                        .offset(y: screenHeight/6.5)
                    SpriteView(
                        scene: scene,
                        options: [.allowsTransparency],
                        shouldRender: {_ in return true}
                    )
                    .ignoresSafeArea()
                    .frame(width: screenWidth, height: screenHeight)
                    .aspectRatio(contentMode: .fit)
                    .offset(y: (screenHeight/6.5) + 20)
                    Image("imgCupHead").offset(y: (screenHeight/6.5) - 180)
                ZStack {
                WhiteRectangleView()
                    .frame(width: 300, height: viewModel.maxProgress == 1 ? 106 : 153)
                        if viewModel.maxProgress == 1 {
                                VStack {
                                    ZStack {
                                        Image("imgPhoneIcon")
                                            .padding(.top, -60)
                                        Image("imgHandIcon")
                                            .padding(.top, -47)
                                            .padding(.leading, 30)
                                    }
                                    Text("스트로우를 꼽아주세요!")
                                        .font(.system(size: 18, weight: .bold))
                                        .padding(.bottom, 1)
                                    Text("스트로우를 꼽으면 벌칙이 담긴 펄이 올라와요")
                                        .font(.system(size: 13, weight: .semibold))
                                }
                        } else {
                                VStack {
                                    Image("imgShakeIcon")
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
                    }
                    .offset(y: viewModel.maxProgress == 1 ? -185 : -225)
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
                        .frame(width: 28)
                        .opacity(moveStraw ? 1 : 0)
                        .offset(y: moveStraw ? -screenHeight : -10)
                        .animation(.easeInOut.delay(1), value: moveStraw)
                    }
                    .frame(width: screenWidth / 1.3, height: screenHeight / 1.8)
                // 빨대
                if viewModel.maxProgress == 1 {
                    Image("imgStraw")
                        .frame(width: 200)
                        .contentShape(Rectangle())
                        .opacity(0.8)
                        .animation(.easeInOut(duration: 1), value: moveStraw)
                        .offset(y: moveStraw ? 0 : dragAmount.height - screenHeight/1.7)
                        .gesture(
                            DragGesture()
                                .onChanged { gesture in
                                    if gesture.translation.height > 0 && gesture.translation.height < 240 {
                                        dragAmount = CGSize(width: 0, height: gesture.translation.height)
                                        withAnimation(.easeInOut) {
                                            viewModel.showWhiteRectangle = false
                                        }
                                    }
                                    isPlug = gesture.translation.height > 150
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
                    Image("cutCup").position(x: screenWidth/2, y: 377)
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
                .padding(.leading, 8)
                .padding(.top, 48)
            }
            .navigationBarHidden(true)
                .onDisappear {
                    moveStraw = false
                    viewModel.showWhiteRectangle = true
                    largePearlIndex = -1
                    viewModel.progress = 0.0
                }
        } else {
            MissionEndingView(state: $goNextView,
                              missionTitle: random.randomWhat.missionDetail.missionTitle,
                              missionTip: random.randomWhat.missionDetail.missionTip,
                              missionColor: random.randomWhat.missionDetail.missionColor)
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
    static var previews: some View {
        StrawView(path: .constant(NavigationPath()))
            .environmentObject(RandomMember())
    }
}
