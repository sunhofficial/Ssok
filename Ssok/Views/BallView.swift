// GachaView
// 008

import SwiftUI

struct BallView: View {
    
    @Binding var getCurrentBall: Bool
    @Binding var getNextBall: Bool
    @State var ballTitle: String
    @State var contents: String
    @State var pearlImage: String = "Back_pearl1"
    
    @State var wid: CGFloat = UIScreen.main.bounds.width
    @State var hei: CGFloat = UIScreen.main.bounds.height
    
    @EnvironmentObject var randomMember: RandomMember
    
    var body: some View {
        if getCurrentBall {
            ZStack {
                Image(pearlImage)
                    .resizable()
                    .foregroundColor(.yellow)
                VStack {
                    Text(ballTitle)
                        .foregroundColor(.white)
                        .font(.system(size: 24))
                    Text(contents)
                        .font(.system(size: 80, weight: .bold))
                        .multilineTextAlignment(.center)
                        .minimumScaleFactor(0.1)
                        .frame(width: wid / 1.6, height: wid / 2.5)
                        .foregroundColor(.white)
                    Text("Touch!")
                        .foregroundColor(.white)
                        .font(.system(size: 20))
                        .opacity(0.5)
                }
            }
            .frame(width: wid / 1.2, height: wid / 1.2)
            .transition(.asymmetric(insertion: .offset(y: -hei), removal: .offset(y: hei)))
            .zIndex(1)
            .onTapGesture {
                withAnimation(.easeInOut(duration: 1)) {
                    getCurrentBall = false
                    getNextBall = true
                }
            }
            .onAppear {
                // MARK: - random으로 who를 만드는 로직
                /*
                 randomMember.randomMeberNames에 접근하면 이름들을 string배열로 받아올 수 있어욥
                 1~6명까지 뜨도록 했어여
                 ex1. ["남식씨", "용주", "지은씨", "창진씨", "잼민서노", "밍"]
                 ex2. ["밍", "잼민서노", "지은씨"]
                 ex3. ["남식씨"]
                 */
                //                    print(randomMember.randomMemberNames)
            }
            
        }
    }
}
