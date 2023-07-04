// GachaView
// 008

import SwiftUI

struct BallView: View {

    @Binding var getCurrentPearl: Int
    @Binding var state: Bool
    var pearlContents : [[String]]
    var cappedCurrentPearl: Int {
           min(getCurrentPearl, 2)
       }

    var body: some View {
        ZStack {
            Image(pearlContents[cappedCurrentPearl][2])
                .resizable()
                .foregroundColor(.yellow)
            VStack {
                Text(pearlContents[cappedCurrentPearl][0])
                    .foregroundColor(.white)
                    .font(.system(size: 24))
                Text(pearlContents[cappedCurrentPearl][1])
                    .font(.system(size: 80, weight: .bold))
                    .multilineTextAlignment(.center)
                    .minimumScaleFactor(0.1)
                    .frame(width: UIScreen.screenWidth / 1.6, height: UIScreen.screenWidth / 2.5)
                    .foregroundColor(.white)
                Text("Touch!")
                    .foregroundColor(.white)
                    .font(.system(size: 20))
                    .opacity(0.5)
            }
        }
        .frame(width: UIScreen.screenWidth / 1.2, height: UIScreen.screenWidth / 1.2)
        .transition(.asymmetric(insertion: .offset(y: -UIScreen.screenHeight),
                                removal: .offset(y: UIScreen.screenHeight)))
        .zIndex(1)
        .id(getCurrentPearl)
        .onTapGesture {
            withAnimation(.easeInOut(duration: 1)) {
                if cappedCurrentPearl >= 2 {
                    state = true
                    getCurrentPearl = 2
                } else {
                    getCurrentPearl += 1
                }
            }
        }
    }
}
