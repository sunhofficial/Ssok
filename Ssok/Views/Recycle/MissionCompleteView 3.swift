//
//  MissionCompleteView.swift
//  Ssok
//
//  Created by 김용주 on 2023/05/14.
//

import SwiftUI

struct MissionCompleteView: View {
    
    @State var Title: String
    @State var background: Color
    @State var state1: Bool = false
    @EnvironmentObject var random: RandomMember
    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    var body: some View {
        if !state1{
            ZStack{
                Rectangle().opacity(0.62)
                
                ZStack{
                    Image("missioncompletecard")
                    VStack(spacing: 40){
                        Text("주어진 미션을 성공했어요").font(.system(size: 24, weight: .black))
                        
                        MissionTitleView(missionTitle: Title, backgroundColor: background.opacity(0.3), borderColor: background.opacity(0.71))
                        
                        
                        NavigationLink(destination: StrawView()) {
                            Text("새로운 미션하기")
                                .font(.system(size: 20, weight: .bold))
                                .foregroundColor(Color("Bg_bottom2")).underline()
                        }
                    }.offset(y:90)
                    
                }
            }.ignoresSafeArea()
            .navigationBarHidden(true)
        } else {
            StrawView()
        }
    }
}

struct MissionCompleteView_Previews: PreviewProvider {
    static var previews: some View {
        MissionCompleteView(Title: "소리 지르기 💥", background: Color("MissionOrange"))
    }
}
