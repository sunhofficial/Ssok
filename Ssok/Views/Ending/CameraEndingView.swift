//
//  CameraEndingView.swift
//  Ssok
//
//  Created by 김용주 on 2023/05/14.
//

import SwiftUI

struct CameraEndingView: View {

    @State var wheresentence: String = ""
    @State var whatsentence: String = ""
    @EnvironmentObject var random: RandomMember
    @ObservedObject var ARview: ARViewModel = ARViewModel()
    @StateObject var permissionManager = PermissionManager()
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @State var missionTitle: String
    @State var missionTip: String
    @State var missionColor: Color
    @Binding var state: Bool
    @State var arstate: String = ""
    @State var cameraState: Bool = false

    var body: some View {

        ZStack {
            ZStack(alignment: .top) {
                Image("imgEndingTop")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: screenWidth)
                    .position(x: screenWidth/2, y: 190)
                HStack {
                    Spacer()
                    HStack {
                        Image("imgRetry")
                        Text("다시뽑기")
                            .font(.system(size: 17, weight: .semibold))
                            .foregroundColor(.white)
                    }
                    .onTapGesture {
                        random.randomWho = setRandomMember(random.members)
                        random.randomWhat = setRandomMission(missions)
                        random.randomWhere = setRandomWhere(whereList)
                        state = false
                    }
                    .padding(.trailing, 20)
                    .padding(.top, 56)
                }
            }
            .edgesIgnoringSafeArea(.top)

            ZStack {
                Text(random.randomWho)
                    .font(.system(size: 20, weight: .bold))
                    .rotationEffect(Angle(degrees: -30))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .minimumScaleFactor(0.1)
                    .frame(width: 75, height: 75)
                    .lineLimit(2)
                    .position(x: screenWidth/2.9, y: 166)

                Text(random.randomWhere)
                    .font(.system(size: 20, weight: .bold))
                    .rotationEffect(Angle(degrees: -30))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .minimumScaleFactor(0.1)
                    .frame(width: 75, height: 75)
                    .lineLimit(2)
                    .position(x: screenWidth/1.81, y: 166)

                Text(String(random.randomWhat.missionTitle.dropLast(2)))
                    .font(.system(size: 20, weight: .bold))
                    .rotationEffect(Angle(degrees: -30))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .minimumScaleFactor(0.1)
                    .frame(width: 75, height: 75)
                    .lineLimit(2)
                    .position(x: screenWidth/1.155, y: 166)
            }
            ZStack {
                Circle()
                    .foregroundColor(.white)
                    .frame(width: 50, height: 50)
                    .shadow(color: Color("Bg_bottom2"), radius: 2)
                Text("📷")
                    .frame(width: 50, height: 50)
            }
            VStack(spacing: 8) {
                Text("얼굴 인식")
                    .font(.system(size: 24, weight: .black))

                Text("미션을 성공하려면 얼굴을 인식해야해요.")
                    .font(.system(size: 13, weight: .light))
                ZStack {
                    RoundedRectangle(cornerRadius: 20)
                        .strokeBorder(Color("Border"), lineWidth: 1.5)
                        .frame(width: 295, height: 175)

                    Text("미션 성공 TIP")
                        .font(.system(size: 20, weight: .black))
                        .foregroundColor(Color("Bg_bottom2"))

                    VStack(spacing: 50) {
                        MissionTitleView(missionTitle: missionTitle,
                                         backgroundColor: missionColor.opacity(0.35),
                                         borderColor: missionColor.opacity(0.71))

                        Text(missionTip)
                            .font(.system(size: 13, weight: .medium))
                            .multilineTextAlignment(.center)
                    }
                }.offset(y: 32)

            }.offset(y: 150)

            Button {
                // 첫 번째 액션
                ARview.ARFrame = true
            } label: {
                Text("미션하기")
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .frame(maxWidth: 350, maxHeight: 50, alignment: .center)
                    .background(Color("Bg_bottom2"))
                    .cornerRadius(12)
            }
            .position(x: screenWidth/2, y: screenHeight-103)

            if ARview.ARFrame == true {
                CameraView(arstate: arstate, cameraState: $cameraState).environmentObject(ARview)
            }
        }
        .navigationBarHidden(true)
    }
}

extension CameraEndingView {
    var backButton: some View {
        Button {
            mode.wrappedValue.dismiss()
        } label: {
            ZStack {
                Rectangle()
                    .frame(width: 40, height: 40)
                    .foregroundColor(.clear)
                Image(systemName: "chevron.backward")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 20, height: 20)
                    .foregroundColor(.white)
                    .bold()
            }
        }
    }
}
