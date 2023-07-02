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
    @StateObject private var viewModel = IntroViewModel()

    var body: some View {
        NavigationStack(path: $viewModel.path) {
            ZStack(alignment: .bottom) {
                ZStack(alignment: .bottom) {
                    Image("imgIntroBg")
                        .resizable()
                        .edgesIgnoringSafeArea(.all)
                    ZStack {
                        ZStack(alignment: .top) {
                            Image("imgIntroPearl")
                                .offset(y: CGFloat(-viewModel.selectedPage * 15))
                            Image("imgIntroWave")
                                .resizable()
                                .frame(width: UIScreen.screenWidth, height: UIScreen.getHeight(194))
                                .aspectRatio(contentMode: .fit)
                        }
                        HStack(spacing: UIScreen.screenHeight/40) {
                            ForEach(0..<4) { pageNumber in
                                Circle()
                                    .fill(
                                        viewModel.selectedPage == pageNumber ?
                                        Color("Bg_top") : Color("Bg")
                                    )
                                    .frame(width: 8, height: 8)
                            }
                        }
                        .padding(.bottom, UIScreen.screenHeight * 0.1)
                    }
                }
                .edgesIgnoringSafeArea(.all)

                TabView(selection: $viewModel.selectedPage) {
                    VStack {
                        Text("쉬는시간이 지루할때,\n쏘옥~")
                            .font(Font.custom24bold())
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                            .padding(.top, UIScreen.getHeight(42))
                        
                        Image("imgHandWithPhone")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: UIScreen.screenWidth * 0.6)
                            .rotationEffect(
                                Angle(degrees: viewModel.isFirst ? -30 : 30)
                            )
                            .animation(Animation
                                .linear(duration: 0.8)
                                .repeatForever(autoreverses: true), value: viewModel.isFirst)
                            .onAppear {
                                viewModel.isFirst = true
                            }
                            .padding(.top, UIScreen.getHeight(65))
                            .padding(.bottom, UIScreen.getHeight(262.5))
                    }
                    .tag(0)

                    VStack(spacing: 38) {
                        Text("각종 미션들이\n펄안에 쏘옥 숨어있어요!")
                            .font(Font.custom24bold())
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                            .padding(.top, UIScreen.getHeight(42))
                        
                        Image("imgIntroPointingPhone")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .padding(.top, UIScreen.getHeight(32.5))
                            .padding(.bottom, UIScreen.getHeight(262.5))
                    }
                    .tag(1)

                    VStack {
                        Text("미션 수행 후\n완료 카드를 받으면 성공!")
                            .font(Font.custom24bold())
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                            .padding(.top, UIScreen.getHeight(42))

                        Image("imgIntroCard")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .padding(
                                EdgeInsets(
                                    top: UIScreen.getHeight(94),
                                    leading: UIScreen.getWidth(10),
                                    bottom: UIScreen.getHeight(338),
                                    trailing: UIScreen.getWidth(10)
                                )
                            )
                    }
                    .tag(2)

                    VStack {
                        Image("imgIntroAdvertising")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .padding(
                                .bottom, UIScreen.getHeight(253)
                            )
                    }
                    .tag(3)
                }
                .onChange(of: viewModel.selectedPage) { _ in
                    viewModel.isFirst.toggle()
                }
                .tabViewStyle(.page(indexDisplayMode: .never))

                Button {
                    viewModel.setPageLast()
                } label: {
                    Text("시작하기")
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .frame(
                            maxWidth: UIScreen.getWidth(351),
                            maxHeight: UIScreen.getHeight(50),
                            alignment: .center
                        )
                        .background(Color("Bg_bottom2"))
                        .cornerRadius(12)
                        .padding(.bottom, UIScreen.getHeight(17))
                }
                .navigationDestination(for: ViewType.self) { viewType in
                    switch viewType {
                    case .addMemberView:
                        AddMemberView(path: $viewModel.path)
                    case .strawView:
                        StrawView(path: $viewModel.path)
                    }
                }
            }
        }
        .onAppear {
            if !viewModel.isIntroActive { viewModel.selectedPage = 3 }
        }
    }
}

struct IntroView_Previews: PreviewProvider {
    static var previews: some View {
        IntroView()
    }
}
