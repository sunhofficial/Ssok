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
    @State var state1: Bool = false
    @EnvironmentObject var random: RandomMember
    @Binding var state: Bool
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
                        random.randomWho = setRandomMember(random.members)
                        random.randomWhat = setRandomMission(missions)
                        random.randomWhere = setRandomWhere(whereList)
                        mode.wrappedValue.dismiss()
                        state = false
                    } label: {
                      Text("새로운 미션하기")
                        .underline()
                        .font(Font.custom20bold())
                        .foregroundColor(Color("Bg_center"))
                        .underline()
                    }
                }.padding(.top, UIScreen.getHeight(180))
            }
        }
        .ignoresSafeArea()
        .navigationBarHidden(true)
    }
}

extension MissionCompleteView {
    var back: some View {
        Button {
            mode.wrappedValue.dismiss()
        } label: {
            ZStack {
                Text("새로운 미션하기")
                    .font(Font.custom20bold())
                    .foregroundColor(Color("Bg_bottom2")).underline()
            }
        }
    }
}

struct MissionCompleteView_Previews: PreviewProvider {
    static var previews: some View {
        MissionCompleteView(title: "HI", background: Color("MissionVoice"), state: .constant(true))
    }
}
