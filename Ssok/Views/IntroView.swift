//
//  IntroView.swift
//  MC2
//
//  Created by 김용주 on 2023/05/06.
//
// IntroView
// 001~003

import SwiftUI
import SpriteKit

struct IntroView: View {
    init() {
        UIPageControl.appearance().currentPageIndicatorTintColor = .white
        UIPageControl.appearance().pageIndicatorTintColor = UIColor.black.withAlphaComponent(1)
    }
    
    let bottle = Bottle(size: CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
    
    let bottle2 = Bottle(size: CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
    
    @State private var isTutorialHidden: Bool = false
    @State private var selection = 0
    
    var body: some View {
        NavigationView {
            GeometryReader{ proxy in
                Rectangle().fill(LinearGradient(gradient: Gradient(colors: [ Color("Bg_bottom"), Color("Bg_top")]), startPoint: .top, endPoint: .bottom)).ignoresSafeArea()
                VStack(spacing: 38) {
                    TabView(selection: $selection) {
                        ZStack{
//                            SpriteView(scene: bottle, options: [.allowsTransparency], shouldRender: {_ in return true}).ignoresSafeArea().frame(width: proxy.size.width, height: proxy.size.height).offset(y:-66)
                            
                            Text("팀원들끼리 리프레쉬하세요").offset(y: -250).font(.system(.title))
                        }
                        .tag(0)
                        
                        ZStack{
//                            SpriteView(scene: bottle2, options: [.allowsTransparency], shouldRender: {_ in return true}).ignoresSafeArea().frame(width: proxy.size.width, height: proxy.size.height).offset(y:-66)
                            
                            Text("미션을 뽑아서 다같이 완수하세요").offset(y: -250).font(.system(.title))
                        }
                        .tag(1)
                        
                        ZStack{
                            Text("Welcome")
                        }
                        .tag(2)
                    }
                    .tabViewStyle(.page)
                    
                    NavigationLink(destination: AddMemberView()) {
                        Text("시작하기")
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                            .frame(maxWidth: 350, maxHeight: 50, alignment: .center)
                            .background(Color("Button"))
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
                selection = 2
            }
        }
    }
}

extension IntroView {

    private func hideTutorialView() {
        let userDefaults = UserDefaults.standard
        userDefaults.set(true, forKey: "hideTutorial")
    }
    
    private func setPageIndex() {
        if selection > 2 {
            selection = 0
        } else {
            selection += 1
        }
    }
}

struct IntroView_Previews: PreviewProvider {
    static var previews: some View {
        IntroView()
    }
}
