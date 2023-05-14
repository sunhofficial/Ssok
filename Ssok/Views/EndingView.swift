// ResultView
// 009

//
//  EndingView.swift
//  MC2
//
//  Created by 김용주 on 2023/05/05.
//

import SwiftUI


struct EndingView: View {
    
    @State var st2: Bool = false
    @State var next = false
    @State var wheresentence: String = ""
    @State var whatsentence: String = ""
    
    @EnvironmentObject var random: RandomMember
    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    var body: some View {
        if next {
            WalkingView()
        }
        else if !st2{
            ZStack{
                Image("endingtop").resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: wid).position(x:wid/2, y:190)
                
                ZStack{
                    Text(random.randomMemberName)
                        .font(.system(size: 18, weight: .bold))
                        .rotationEffect(Angle(degrees: -30)).foregroundColor(.white).multilineTextAlignment(.center).minimumScaleFactor(0.1)
                        .frame(width: 85, height: 85)
                        .position(x:wid/2.9, y:210)
                    
                    Text(wheresentence)
                        .font(.system(size: 18, weight: .bold))
                        .rotationEffect(Angle(degrees: -30)).foregroundColor(.white).multilineTextAlignment(.center).minimumScaleFactor(0.1)
                        .frame(width: 85, height: 85)
                        .position(x:wid/1.81, y:210)
                    
                    Text(whatsentence)
                        .font(.system(size: 18, weight: .bold))
                        .rotationEffect(Angle(degrees: -30)).foregroundColor(.white).multilineTextAlignment(.center).minimumScaleFactor(0.1)
                        .frame(width: 85, height: 85)
                        .position(x:wid/1.155, y:210)
                }
                
                Circle()
                    .foregroundColor(.white)
                    .frame(width: 50, height: 50)
                    .shadow(color: Color("Bg_bottom2"), radius: 2)
                    Text("📢")
                        .frame(width: 50, height: 50)
                
                VStack(spacing: 8){
                    Text("데시벨 측정기")
                        .font(.system(size: 24, weight: .black))
                    
                    Text("미션을 성공하려면 데시벨을 충족시켜야해요")
                        .font(.system(size:13, weight: .light))
                    
                    RoundedRectangle(cornerRadius: 20)
                        .strokeBorder(Color("Border"), lineWidth: 1.5)
                        .frame(width: 295, height: 175).offset(y:32)
                    
                }.offset(y:150)
                
                Button(action: {
                    next = true
                }){
                    Text("미션하기")
                }.foregroundColor(.white)
                    .fontWeight(.bold)
                    .frame(maxWidth: 350, maxHeight: 50, alignment: .center)
                    .background(Color("Bg_bottom2"))
                    .cornerRadius(12)
//                    .offset(y:363)
                    .position(x:wid/2, y:hei-59)
                
                Button(action: {
                    random.randomMemberName = setRandomMember(random.members)
                    st2 = true
                }){
                    Image("retry")
                }.position(x: wid - 57, y:73)
            }
            .ignoresSafeArea(.all)
            .navigationBarHidden(true)
        } else if st2 {
            StrawView()
        }
    }
}

struct EndingView_Previews: PreviewProvider {
    static let random = RandomMember()
    
    static var previews: some View {
        EndingView()
            .environmentObject(random)
    }
}
