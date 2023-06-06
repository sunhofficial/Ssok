//
//  MissionCompleteView.swift
//  Ssok
//
//  Created by 김용주 on 2023/05/14.
//

import SwiftUI

struct MissionCameraCompleteView: View {
    @State var title: String
    @State var background: Color
    @State var state1: Bool = false
    @EnvironmentObject var random: RandomMember
    @Binding var cameraState: Bool
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @EnvironmentObject var ARview: ARViewModel
    var body: some View {
        ZStack {
            Rectangle().opacity(0.62)

            ZStack {
                Image("missioncompletecard")
                VStack(spacing: 40) {
                    Text("주어진 미션을 성공했어요").font(.system(size: 24, weight: .black))

                    MissionTitleView(missionTitle: title,
                                     backgroundColor: background.opacity(0.3),
                                     borderColor: background.opacity(0.71))

//                    NavigationLink(destination: StrawView()) {
//                        Text("새로운 미션하기")
//                          .underline()
//                          .font(.system(size: 20, weight: .bold))
//                          .foregroundColor(Color("Bg_center"))
//                          .underline()
//                    }
//                    .simultaneousGesture(TapGesture().onEnded {
//                        random.randomWho = setRandomMember(random.members)
//                        random.randomWhat = setRandomMission(missions)
//                        random.randomWhere = setRandomWhere(whereList)
//                    })
                }
                .offset(y: 90)

            }
        }.ignoresSafeArea()
    }
}

extension MissionCameraCompleteView {
    var back: some View {
        Button {

            mode.wrappedValue.dismiss()
        } label: {
            ZStack {
                Text("새로운 미션하기")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(Color("Bg_bottom2")).underline()
            }
        }
    }
}
