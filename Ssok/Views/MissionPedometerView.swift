//
//  MissionPedometerView.swift
//  Ssok
//
//  Created by 김민 on 2023/05/14.
//

import SwiftUI

struct MissionPedometerView: View {
    
    var body: some View {
        VStack(spacing: 64) {
            MissionTopView(title: "만보기", description: "춤을 춰서 만보기의 횟수를 채워야 해요", iconImage: "🪩")
            
            MissionTitleView(missionTitle: "춤추기 💃🕺🏻", backgroundColor: Color("MissionPurple").opacity(0.28), borderColor: Color("MissionPurple"))
            
            ZStack {
                CircularProgressView()
                    .frame(width: 308, height: 308)
                
                VStack {
                    Text("15").font(.system(size: 60, weight: .bold)) + Text("회").font(.system(size: 40, weight: .bold))
                    Text("목표 진동수\n100회")
                        .font(.system(size: 18))
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color("GoalRed"))
                }
            }
            
            Text("더더더더더더")
                .font(.system(size: 48, weight: .bold))
                .foregroundColor(Color("Gray"))
                .padding(.bottom, 94)
        }
    }
}

struct MissionPedometerView_Previews: PreviewProvider {
    static var previews: some View {
        MissionPedometerView()
    }
}
