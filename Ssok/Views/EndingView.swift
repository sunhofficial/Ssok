// ResultView
// 009

//
//  EndingView.swift
//  MC2
//
//  Created by 김용주 on 2023/05/05.
//

import SwiftUI
import CoreMotion

struct EndingView: View {
    
    @State var st2: Bool = false
    @State var startAnimation: CGFloat = 0
    @State var watertop: CGFloat = 0
    @State var moneDropping: CGFloat = -270
    @State var rotateMoney: CGFloat = 0
    @State var showingBall = false
    @State var isAnimation: Bool = false
    
    @State var wheresentence: String = ""
    @State var whatsentence: String = ""
    
    @State var wid = UIScreen.main.bounds.width
    @State var hei = UIScreen.main.bounds.height
    
    
    var body: some View {
        if !st2{
            ZStack{
                GeometryReader{proxy in
                    let size = proxy.size
                    ZStack{
                        Rectangle().fill(LinearGradient(gradient: Gradient(colors: [ Color("Bg_bottom"), Color("Bg_top")]), startPoint: .top, endPoint: .center)).mask{WaterWave(progress: 0.90, waveHeight: 0.03, offset: startAnimation)}
                        Rectangle().fill(LinearGradient(gradient: Gradient(colors: [ Color("Bg_bottom"), Color("Bg_center")]), startPoint: .top, endPoint: .center))
                            .mask{
                                WaterWave2(progress: 0.625, waveHeight: 0.03, offset: startAnimation)
                        }
                        Rectangle().fill(LinearGradient(gradient: Gradient(colors: [ Color("Bg_bottom"), Color("Bg_top")]), startPoint: .center, endPoint: .bottom)).mask{
                            WaterWave(progress: 0.35, waveHeight: 0.03, offset: startAnimation)
                        }
                    }.onAppear {
                        // Lopping Animation
                        withAnimation(
                            .linear(duration: 3)
                            .repeatForever(autoreverses: false)){
                                // If you set value less than the rect width it will not finish completely
                                startAnimation = size.width - 30
                            }
                    }
                }
                VStack(spacing:100){
                    Text("소다가")
                        .font(.system(size: 75, weight: .bold))
                        .multilineTextAlignment(.center)
                        .minimumScaleFactor(0.1)
                        .frame(width: wid, height: wid / 3)
                        .foregroundColor(.black)
                    
                    
                    Text(wheresentence)
                        .font(.system(size: 75, weight: .bold))
                        .multilineTextAlignment(.center)
                        .minimumScaleFactor(0.1)
                        .frame(width: wid, height: wid / 3)
                        .foregroundColor(.black)
                    
                    Text(whatsentence)
                        .font(.system(size: 75, weight: .bold))
                        .multilineTextAlignment(.center)
                        .minimumScaleFactor(0.1)
                        .frame(width: wid, height: wid / 3)
                        .foregroundColor(.black)
                }
                Button(action: {st2 = true}){
                    Text("Once Again?")
                }.foregroundColor(.white)
                    .fontWeight(.bold)
                    .frame(maxWidth: 350, maxHeight: 50, alignment: .center)
                    .background(Color("EndingButton"))
                    .cornerRadius(12)
//                    .offset(y:363)
                    .position(x:wid/2, y:hei-75)
            }
            .ignoresSafeArea(.all)
            .navigationBarHidden(true)
        } else {
            StrawView()
        }
    }
}

struct EndingView_Previews: PreviewProvider {
    static var previews: some View {
        EndingView()
    }
}

struct WaterWave: Shape{
    var progress: CGFloat
    var waveHeight: CGFloat

    var offset: CGFloat
    // Enabling Animation
    var animatableData: CGFloat {
        get{offset}
        set{offset = newValue}
    }

    func path(in rect: CGRect) -> Path {
        return Path{path in

            path.move(to: .zero)

            // MARK: Drawing Waves using
            let progressHeight: CGFloat = (1 - progress) * rect.height
            let height = waveHeight * rect.height
            for value in stride(from: 0, to: rect.width+2, by: 2){
                let x: CGFloat = value
                let sine: CGFloat = sin(Angle(degrees: value + offset).radians)
                let y: CGFloat = progressHeight + (height * sine)
                path.addLine (to: CGPoint (x: x, y: y))
            }

            // Bottom Portion
            path.addLine (to: CGPoint (x: rect.width, y: rect.height))
            path.addLine (to: CGPoint (x: 0, y: rect.height))
        }
    }
}

struct WaterWave2: Shape{
    var progress: CGFloat
    var waveHeight: CGFloat
    
    var offset: CGFloat
    // Enabling Animation
    var animatableData: CGFloat {
        get{offset}
        set{offset = newValue}
    }
    
    func path(in rect: CGRect) -> Path {
        return Path{path in
            
            path.move(to: .zero)
            
            // MARK: Drawing Waves using
            let progressHeight: CGFloat = (1 - progress) * rect.height
            let height = waveHeight * rect.height
            for value in stride(from: 0, to: rect.width + 2, by: 2){
                let x: CGFloat = value
                let sine: CGFloat = cos(Angle(degrees: value - offset).radians)
                let y: CGFloat = progressHeight + (height * sine)
                path.addLine (to: CGPoint (x: x, y: y))
            }
            
            // Bottom Portion
            path.addLine (to: CGPoint (x: rect.width, y: rect.height))
            path.addLine (to: CGPoint (x: 0, y: rect.height))
        }
    }
}
