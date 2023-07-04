//
//  MissionCompleteView.swift
//  Ssok
//
//  Created by 김용주 on 2023/05/14.
//

import SwiftUI

struct MissionCompleteView: View {
    
    @State var title: String
    @State var background: Color
    @Binding var state: Bool
    @Binding var largePearlIndex: Int
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>

    var body: some View {
        ZStack {
            Rectangle().opacity(0.62)
            ZStack {
                Image("imgMissionCompleteCard")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(.top, UIScreen.getHeight(190))
                    .padding(.bottom, UIScreen.getHeight(190))
                VStack(spacing: UIScreen.getHeight(40)) {
                    Text("주어진 미션을 성공했어요").font(Font.custom24black())
                    MissionTitleView(missionTitle: title,
                        missionColor: background)
                    Button {
                        largePearlIndex = -1
                        mode.wrappedValue.dismiss()
                        state = false
                    } label: {
                      Text("새로운 미션하기")
                        .underline()
                        .font(Font.custom20bold())
                        .foregroundColor(Color("Bg_center"))
                        .underline()
                    }
                }
                .padding(.top, UIScreen.getHeight(180))
            }
        }
        .ignoresSafeArea()
        .navigationBarHidden(true)
    }
}

struct MissionCompleteView_Previews: PreviewProvider {
    static var previews: some View {
        MissionCompleteView(title: "HI",
                            background: Color("MissionVoice"),
                            state: .constant(true),
                            largePearlIndex: .constant(2))
    }
}
