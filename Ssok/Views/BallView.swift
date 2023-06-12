// GachaView
// 008

import SwiftUI

struct BallView: View {

    @Binding var getCurrentPearl: Int
    @Binding var state: Bool
    var pearlContents : [[String]]

    var body: some View {
        ZStack {
            Image(pearlContents[getCurrentPearl][2])
                .resizable()
                .foregroundColor(.yellow)
            VStack {
                Text(pearlContents[getCurrentPearl][0])
                    .foregroundColor(.white)
                    .font(.system(size: 24))
                Text(pearlContents[getCurrentPearl][1])
                    .font(.system(size: 80, weight: .bold))
                    .multilineTextAlignment(.center)
                    .minimumScaleFactor(0.1)
                    .frame(width: screenWidth / 1.6, height: screenWidth / 2.5)
                    .foregroundColor(.white)
                Text("Touch!")
                    .foregroundColor(.white)
                    .font(.system(size: 20))
                    .opacity(0.5)
            }
        }
        .frame(width: screenWidth / 1.2, height: screenWidth / 1.2)
        .transition(.asymmetric(insertion: .offset(y: -screenHeight), removal: .offset(y: screenHeight)))
        .zIndex(1)
        .id(getCurrentPearl)
        .onTapGesture {
            withAnimation(.easeInOut(duration: 1)) {
                if getCurrentPearl >= 2 {
                    state = true
                    getCurrentPearl = 2
                } else {
                    getCurrentPearl += 1
                }
            }
        }
    }
}
