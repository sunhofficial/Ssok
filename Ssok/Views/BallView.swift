// GachaView
// 008

import SwiftUI

struct BallView: View {

    @Binding var getCurrentBall: Bool
    @Binding var getNextBall: Bool
    @Binding var state: Bool
    @State var stBool: Bool
    @State var ballTitle: String
    @State var contents: String
    @State var pearlImage: String = "Back_pearl1"

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
                withAnimation(.linear) {
                    state = stBool
                }
            }
        }
    }
}
