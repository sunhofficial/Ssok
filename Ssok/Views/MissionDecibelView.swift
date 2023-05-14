//
//  MissonDecibelView.swift
//  Ssok
//
//  Created by 김민 on 2023/05/14.
//

import SwiftUI

struct MissionDecibelView: View {
    var body: some View {
        
        VStack(spacing: 64) {
            MissionTopView(title: "데시벨 측정기", description: "미션을 성공하려면 데시벨을 충족시켜야 해요", iconImage: "📢")
            
            MissionTitleView(missionTitle: "소리 지르기 💥", backgroundColor: Color("MissionOrange"), borderColor: Color("MissionOrangeBorder"))
            
            ZStack {
                CircularProgressView()
                    .frame(width: 308, height: 308)
                
                VStack {
                    Text("15").font(.system(size: 60, weight: .bold)) + Text("dB").font(.system(size: 40, weight: .bold))
                    Text("목표 데시벨\n30dB")
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

struct MissionDecibelView_Previews: PreviewProvider {
    static var previews: some View {
        MissionDecibelView()
    }
}
