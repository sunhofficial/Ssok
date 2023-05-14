//
//  MissonDecibelView.swift
//  Ssok
//
//  Created by 김민 on 2023/05/14.
//

import SwiftUI

struct MissionDecibelView: View {
    var body: some View {
        
        VStack(spacing: 58) {
            MissionTopView(title: "데시벨 측정기", description: "미션을 성공하려면 데시벨을 충족시켜야 해요", iconImage: "📢")
            
            MissionTitleView(missionTitle: "소리 지르기 💥", backgroundColor: Color("MissionOrange"), borderColor: Color("MissionOrangeBorder"))
            
            CircularProgressView()
                .frame(width: 308, height: 308)
            
            Text("더더더더더더")
                .font(.system(size: 48, weight: .bold))
                .foregroundColor(Color("Gray"))
            
            Spacer()
        }
    }
}

struct MissionDecibelView_Previews: PreviewProvider {
    static var previews: some View {
        MissionDecibelView()
    }
}
