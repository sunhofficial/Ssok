//
//  IntroView.swift
//  MC2
//
//  Created by 김용주 on 2023/05/06.
//
// IntroView
// 001~003

import SwiftUI

struct IntroView: View {

    @State private var selectedPage = 0
    @State private var isfirst = false
    @AppStorage("Tutorial") private var isIntroActive = true
    @State private var path = NavigationPath()

    var body: some View {
        NavigationStack(path: $path) {
            ZStack(alignment: .bottom) {
                ZStack(alignment: .bottom) {
                    Image("imgIntroBg")
                        .resizable()
                        .edgesIgnoringSafeArea(.all)
                    ZStack {
                        ZStack(alignment: .top) {
                            Image("imgIntroPearl").offset(y: CGFloat(-selectedPage * 15))
                            Image("imgIntroWave")
                                .resizable()
                                .frame(width: UIScreen.screenWidth, height: 200)
                                .aspectRatio(contentMode: .fit)
                        }
                        HStack(spacing: 12) {
                            ForEach(0..<4) { pageNumber in
                                Circle()
                                    .fill(selectedPage == pageNumber ? Color("Bg_top") : Color("Bg"))
                                    .frame(width: 8, height: 8)
                            }
                        }
                        .padding(.bottom, 80)
                    }
                }
                .edgesIgnoringSafeArea(.all)

                TabView(selection: $selectedPage) {
                    VStack(spacing: 66) {
                        Text("쉬는시간이 지루할때,\n쏘옥~")
                            .font(.system(size: 24, weight: .bold))
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)

                        Image("imgHandWithPhone")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: UIScreen.screenWidth - 173)
                            .rotationEffect(
                                Angle(degrees: isfirst ? -30 : 30)
                            )
                            .animation(Animation
                                .linear(duration: 0.8)
                                .repeatForever(autoreverses: true), value: isfirst)
                            .onAppear {
                                isfirst = true
                            }

                        Spacer()
                            .frame(height: 160)
                    }
                    .tag(0)

                    VStack(spacing: 38) {
                        Text("각종 미션들이\n펄안에 쏘옥 숨어있어요!")
                            .font(.system(size: 24, weight: .bold))
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)

                        Image("imgIntroPointingPhone")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: UIScreen.screenWidth - 74)

                        Spacer()
                            .frame(height: 160)
                    }
                    .tag(1)

                    VStack(spacing: 109) {
                        Text("미션 수행 후\n완료 카드를 받으면 성공!")
                            .font(.system(size: 24, weight: .bold))
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)

                        Image("imgIntroCard")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: UIScreen.screenWidth - 22)

                        Spacer()
                            .frame(height: 160)
                    }
                    .tag(2)

                    VStack(spacing: 40) {
                        Image("imgIntroAdvertising")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: UIScreen.screenWidth - 32)

                        Spacer()
                            .frame(height: 160)
                    }
                    .tag(3)
                }
                .onChange(of: selectedPage) { _ in
                    isfirst.toggle()
                }
                .tabViewStyle(.page(indexDisplayMode: .never))

                Button {
                    isIntroActive = false
                    path.append(ViewType.addMemberView)
                } label: {
                    Text("시작하기")
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .frame(maxWidth: 350, maxHeight: 50, alignment: .center)
                        .background(Color("Bg_bottom2"))
                        .cornerRadius(12)
                }
                .navigationDestination(for: ViewType.self) { viewType in
                    switch viewType {
                    case .addMemberView:
                        AddMemberView(path: $path)
                    case .strawView:
                        StrawView(path: $path)
                    }
                }
            }
        }
        .onAppear {
            if !isIntroActive { selectedPage = 3 }
        }
    }
}

struct IntroView_Previews: PreviewProvider {
    static var previews: some View {
        IntroView()
    }
}
