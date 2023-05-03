//
//  ContentView.swift
//  MC2-Snack
//
//  Created by 관식 on 2023/05/03.
//

import SwiftUI

struct ContentView: View {
    
    @State var isAnimation: Bool = false
    @State var upBalls: Bool = false
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                Color("bg")
                    .edgesIgnoringSafeArea(.all)
                VStack(spacing: 40) {
                    Spacer()
                        .frame(height: 40)
                    // 텍스트
                    VStack(spacing: 24) {
                        Text("빨대를 꼽아주세요")
                            .foregroundColor(.white)
                            .font(.system(size: 28, weight: .bold))
                        Image(systemName: "arrow.down")
                            .resizable()
                            .foregroundColor(.white)
                            .frame(width: 24, height: 24)
                    }
                    .opacity(isAnimation ? 0 : 1)
                    // 컵
                    ZStack {
                        Rectangle()
                            .stroke(Color.gray, lineWidth: 4)
                        VStack {
                            Spacer()
                            Circle()
                                .fill(.yellow)
                            Circle()
                                .fill(.green)
                            Circle()
                                .fill(.blue)
                        }
                        .opacity(isAnimation ? 1 : 0)
                        .offset(y: upBalls ? 0 : -geo.size.height/1.5)
                        .animation(.default, value: upBalls)
                        .frame(width: 28)
                    }
                    .frame(width: geo.size.width / 1.3, height: geo.size.height / 1.7)
                }
                // 빨대
                Rectangle()
                    .fill(Color.red)
                    .opacity(0.5)
                    .frame(width: 32, height: 400)
                    .offset(y: isAnimation ? 0 : -geo.size.height/1.5)
                    .animation(.easeInOut(duration: 1.5), value: isAnimation)
            }
            .onTapGesture {
                isAnimation.toggle()
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
