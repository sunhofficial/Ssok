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
    @State private var isTutorialHidden = false
    @State private var isfirst = false
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottom) {
                ZStack(alignment: .bottom) {
                    Image("intro_bg")
                        .resizable()
                        .edgesIgnoringSafeArea(.all)
                    ZStack {
                        ZStack(alignment: .top) {
                            Image("intro_pearl").offset(y: CGFloat(-selectedPage * 15))
                            Image("intro_wave")
                                .resizable()
                                .frame(width: UIScreen.main.bounds.width, height: 200)
                                .aspectRatio(contentMode: .fit)
                        }
                        HStack(spacing: 12) {
                            ForEach(0..<4) { pageNumber in
                                Circle()
                                    .fill(selectedPage == pageNumber ? Color("Bg_top") : Color("Bg"))
                                    .frame(width: 8, height: 8)
                            }
                        }
                        .padding(.bottom, 81)
                    }
                }
                .edgesIgnoringSafeArea(.all)
                
                TabView(selection: $selectedPage) {
                    VStack(spacing: 66) {
                        
                        Text("쉬는시간이 지루할때,\n쏘옥~")
                            .font(.system(size: 24, weight: .bold))
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                        
                        Image("HandWithPhone").resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: wid - 173)
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

                    
                    VStack(spacing: 38) {
                        
                        Text("각종 미션들이\n펄안에 쏘옥 숨어있어요!")
                            .font(.system(size: 24, weight: .bold))
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                        
                        Image("Intro2")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: wid - 74)
                           
                        Spacer()
                            .frame(height: 160)
                    }
                    .tag(1)
                    
                    VStack(spacing: 109) {
                        Text("미션 수행 후\n완료 카드를 받으면 성공!")
                            .font(.system(size: 24, weight: .bold))
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                        
                        Image("Intro3")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: wid - 22)
                        Spacer()
                            .frame(height: 160)
                    }
                    .tag(2)
                    
                    VStack(spacing: 40) {
                        Image("Intro4")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: wid - 32)
                        Spacer()
                            .frame(height: 160)
                    }
                    .tag(3)
                    
                }
                .onChange(of: selectedPage, perform:  { index in
                    isfirst.toggle()
                })
                .tabViewStyle(.page(indexDisplayMode: .never))
       
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
        .onAppear {
            isTutorialHidden = UserDefaults.standard.bool(forKey: "hideTutorial")
            if isTutorialHidden {
                selectedPage = 3
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
