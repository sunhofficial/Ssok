//
//  CameraEndingView.swift
//  Ssok
//
//  Created by 김용주 on 2023/05/14.
//

import SwiftUI

struct CameraEndingView: View {
    
    @State var viewControl: String = "default"
    @State var wheresentence: String = ""
    @State var whatsentence: String = ""
    @State var arstate: String = ""
    
    @EnvironmentObject var random: RandomMember
    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    @State var missionTitle: String
    @State var missionTip: String
    @State var missionColor: Color
    @Binding var st: Bool
    
    
    var body: some View {
        
        switch viewControl{
        case arstate:
            MissionSmileView(ARstate: arstate)
        default:
            ZStack{
                ZStack(alignment: .top) {
                    Image("endingtop").resizable()
                        .aspectRatio(contentMode: .fit)
                    .frame(width: wid).position(x:wid/2, y:190)
                    HStack {
                        Spacer()
                        HStack {
                            Image("retry")
                            Text("다시뽑기")
                                .font(.system(size: 17, weight: .semibold))
                                .foregroundColor(.white)
                        }
                        .onTapGesture {
                            random.randomWho = setRandomMember(random.members)
                            random.randomWhat = setRandomMission(missions)
                            random.randomWhere = setRandomWhere(whereList)
                            st = false
                        }
                        .padding(.trailing, 20)
                        .padding(.top, 56)
                        
                    }
                }
                
                ZStack{
                    Text(random.randomWho)
                        .font(.system(size: 18, weight: .bold))
                        .rotationEffect(Angle(degrees: -30))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .minimumScaleFactor(0.1)
                        .frame(width: 85, height: 85)
                        .position(x:wid/2.9, y:210)
                    
                    Text(wheresentence)
                        .font(.system(size: 18, weight: .bold))
                        .rotationEffect(Angle(degrees: -30))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .minimumScaleFactor(0.1)
                        .frame(width: 85, height: 85)
                        .position(x:wid/1.81, y:210)
                    
                    Text(whatsentence)
                        .font(.system(size: 18, weight: .bold))
                        .rotationEffect(Angle(degrees: -30))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .minimumScaleFactor(0.1)
                        .frame(width: 85, height: 85)
                        .position(x:wid/1.155, y:210)
                }
                ZStack{
                    Circle()
                        .foregroundColor(.white)
                        .frame(width: 50, height: 50)
                        .shadow(color: Color("Bg_bottom2"), radius: 2)
                    Text("📷")
                        .frame(width: 50, height: 50)
                }
                
                VStack(spacing: 8){
                    Text("얼굴 인식 카메라")
                        .font(.system(size: 24, weight: .black))
                    
                    Text("미션을 성공하려면 얼굴을 인식해야해요")
                        .font(.system(size:13, weight: .light))
                    ZStack{
                        RoundedRectangle(cornerRadius: 20)
                            .strokeBorder(Color("Border"), lineWidth: 1.5)
                            .frame(width: 295, height: 175)
                        
                        Text("미션 성공 TIP")
                            .font(.system(size: 20, weight: .black))
                            .foregroundColor(Color("Bg_bottom2"))
                        
                        VStack(spacing: 50){
                            MissionTitleView(missionTitle: missionTitle, backgroundColor: missionColor.opacity(0.35), borderColor: missionColor.opacity(0.71))
                            
                            Text(missionTip)
                                .font(.system(size: 13, weight: .medium))
                                .multilineTextAlignment(.center)
                        }
                    }.offset(y:32)
                    
                }.offset(y:150)
                
                Button(action: {
                    viewControl = arstate
                }){
                    Text("미션하기")
                }.foregroundColor(.white)
                    .fontWeight(.bold)
                    .frame(maxWidth: 350, maxHeight: 50, alignment: .center)
                    .background(Color("Bg_bottom2"))
                    .cornerRadius(12)
                    .position(x:wid/2, y:hei-59)
            }
            .ignoresSafeArea(.all)
            .navigationBarHidden(true)
        }
    }
}
//
//struct CameraEndingView_Previews: PreviewProvider {
//    static let random = RandomMember()
//
//    static var previews: some View {
//        CameraEndingView(missionTitle: "소리 지르기 💥", missionTip: "장소로 이동해서 미션하기 버튼을 누르고\n얼굴을 인식시켜 미션 완료까지 두 눈을 윙크하세요 ", missionColor: Color("MissionOrange"))
//            .environmentObject(random)
//    }
//}
