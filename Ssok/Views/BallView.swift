// GachaView
// 008

import SwiftUI

struct BallView: View {
    
    @Binding var getCurrentBall: Bool
    @Binding var getNextBall: Bool
    @State var ballTitle: String
    @State var contents: String
    @State var pearlImage: String = "Back_pearl1"
    @State var c0x: Double
    @State var c0y: Double
    @State var c1x: Double
    @State var c1y: Double
    @State var duration: Double
    
    @State var wid: CGFloat = UIScreen.main.bounds.width
    @State var hei: CGFloat = UIScreen.main.bounds.height
    
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
                withAnimation(.timingCurve(c0x, c0y, c1x, c1y, duration: duration)) {
                    getCurrentBall = false
                    getNextBall = true
                }
            }
        }
    }
}
