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
    
    @State var selectedPage: Int = 0
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .bottom) {
                ZStack(alignment: .bottom) {
                    Image("intro_bg")
                        .resizable()
                        .edgesIgnoringSafeArea(.all)
                    ZStack {
                        ZStack(alignment: .top) {
                            Image("intro_pearl")
                            Image("intro_wave")
                                .resizable()
                                .frame(width: UIScreen.main.bounds.width, height: 200)
                                .aspectRatio(contentMode: .fit)
                        }
                        HStack(spacing: 6) {
                            Circle()
                                .fill(selectedPage == 0 ? Color("Bg_top") : Color("Bg"))
                                .frame(width: 6, height: 6)
                            Circle()
                                .fill(selectedPage == 1 ? Color("Bg_top") : Color("Bg"))
                                .frame(width: 6, height: 6)
                            Circle()
                                .fill(selectedPage == 2 ? Color("Bg_top") : Color("Bg"))
                                .frame(width: 6, height: 6)
                        }
                        .padding(.bottom, 48)
                    }
                }
                .edgesIgnoringSafeArea(.all)
                TabView(selection: $selectedPage) {
                    VStack(spacing: 40) {
                        Text("컵을 흔들어\n내용물을 섞어주세요")
                            .foregroundColor(.white)
                            .font(.system(size: 28, weight: .bold))
                            .multilineTextAlignment(.center)
                            .lineSpacing(4)
                        Image("intro_cup")
                            .frame(width: UIScreen.main.bounds.width-40)
                            .aspectRatio(contentMode: .fit)
                        Spacer()
                            .frame(height: 160)
                    }
                    .tag(0)
                    VStack(spacing: 40) {
                        Text("미션이 담긴 펄이\n각각 랜덤으로 나와요")
                            .foregroundColor(.white)
                            .font(.system(size: 28, weight: .bold))
                            .multilineTextAlignment(.center)
                            .lineSpacing(4)
                        Image("intro_balls")
                            .frame(width: UIScreen.main.bounds.width-40)
                            .aspectRatio(contentMode: .fit)
                        Spacer()
                            .frame(height: 160)
                    }
                    .tag(1)
                    VStack(spacing: 40) {
                        Image("intro_last")
                        Spacer()
                            .frame(height: 160)
                    }
                    .tag(2)
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
                NavigationLink(destination: AddMemberView()) {
                    Text("시작하기")
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(Color("BrownBlack"))
                        .cornerRadius(12)
                        .padding(.horizontal, 20)
                }
            }
        }
    }
}

extension IntroView {
    
    private func hideTutorialView() {
        let userDefaults = UserDefaults.standard
        userDefaults.set(true, forKey: "hideTutorial")
    }
    
}

struct IntroView_Previews: PreviewProvider {
    static var previews: some View {
        IntroView()
    }
}
