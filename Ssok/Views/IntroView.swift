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
    @State var isTutorialHidden: Bool = false
    @State var isfirst: Bool = false
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .bottom) {
                ZStack(alignment: .bottom) {
                    Image("intro_bg")
                        .resizable()
                        .edgesIgnoringSafeArea(.all)
                    ZStack {
                        ZStack(alignment: .top) {
                            Image("intro_pearl").offset(y: CGFloat(-selectedPage * 20))
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
                    VStack(spacing: 25) {
                        Image("Introtext1").resizable().aspectRatio(contentMode: .fit
                        ).frame(width: wid,height: 186.5)
                        
                        Image("sign").resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: wid - 190)
                            .rotationEffect(
                                Angle(
                                    degrees: isfirst ? -30 : 30
                                )
                            )
                            .animation(Animation.linear(duration: 0.8).repeatForever(autoreverses: true), value: isfirst)
                            .onAppear{
                                isfirst = true
                            }
                    
                        Spacer()
                            .frame(height: 160)

                    }
                    .tag(0)

                    
                    VStack(spacing: 40) {
                        Image("Intro2")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: UIScreen.main.bounds.width - 74)
                           
                        Spacer()
                            .frame(height: 160)
                    }
                    .tag(1)
                    
                    VStack(spacing: 40) {
                        Image("Intro3")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: UIScreen.main.bounds.width - 32)
                        Spacer()
                            .frame(height: 160)
                    }
                    .tag(2)
                    
                }
                .onChange(of: selectedPage, perform:  { index in
                        isfirst = true
                })
                .tabViewStyle(.page(indexDisplayMode: .never))
       
                if selectedPage == 2{
                    NavigationLink(destination: AddMemberView()) {
                        Text("시작하기").foregroundColor(.white)
                            .fontWeight(.bold)
                            .frame(maxWidth: 350, maxHeight: 50, alignment: .center)
                            .background(Color("Bg_bottom2"))
                            .cornerRadius(12)
                    }
                    .simultaneousGesture(TapGesture().onEnded {
                        hideTutorialView()
                    })
                }
            }
        }
        .onAppear {
            isTutorialHidden = UserDefaults.standard.bool(forKey: "hideTutorial")
            if isTutorialHidden {
                selectedPage = 2
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
