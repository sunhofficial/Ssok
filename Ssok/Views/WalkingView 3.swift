//
//  WalkingView.swift
//  Ssok
//
//  Created by 김용주 on 2023/05/14.
//

import SwiftUI
import CoreMotion

struct WalkingView: View {
    let motionmanager = CMMotionManager()
    let activityManager = CMMotionActivityManager()
    let pedometer = CMPedometer()
    
    @State var i:Int = 0
    
    @State var stepcount: Int = 0
    
    @State var currentgravity = 0
    @State var previousgravity = 0
    @State var gravityx: Double = 0
    @State var backstate: Bool = false
    
    @EnvironmentObject var random: RandomMember
    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    let more: String = "더"
    var body: some View {
        if !backstate{
            ZStack{
                Image("stepcounterlogo").position(CGPoint(x:wid/2,y:87.5))
                
                Text("\(stepcount) 흔듦").bold().font(.system(size: 90)).offset(y:-60)
                
                if stepcount != 10{
                    HStack{
                        if stepcount < 10 && stepcount > 8{
                            Text(more)
                        }
                        if stepcount < 10 && stepcount > 6{
                            Text(more)
                        }
                        if stepcount < 10 && stepcount > 4{
                            Text(more)
                        }
                        if stepcount < 10 && stepcount > 2{
                            Text(more)
                        }
                        if stepcount < 10 && stepcount > 0{
                            Text(more)
                        }
                    }.bold()
                        .font(.system(size: 50))
                        .frame(width: wid, alignment: .center)
                        .position(CGPoint(x: wid/2, y: hei-200))
                }
                
                if stepcount == 10 {
                    Button(action: {
                        random.randomMemberName = setRandomMember(random.members)
                        backstate = true}){
                        Image("missionsuccess")
                    }
                }
                
            }
            .onReceive(timer) { input in
                
                if motionmanager.isDeviceMotionAvailable {
                    motionmanager.deviceMotionUpdateInterval = 0.2
                    motionmanager.startDeviceMotionUpdates(to: OperationQueue.main) { data,error in
                        gravityx = data?.gravity.x ?? 0
                        
                        if gravityx > 0.3 {
                            currentgravity = 1
                        } else if gravityx <= 0.3 && gravityx >= -0.3 {
                            currentgravity = 0
                        } else if gravityx < -0.3 {
                            currentgravity = 2
                        }
                        
                        if currentgravity == previousgravity && previousgravity != 0 {
                            previousgravity = currentgravity
                        } else if currentgravity != previousgravity{
                            if stepcount != 10 {
                                stepcount += 1
                            }
                            previousgravity = currentgravity
                        }
                    }
                    
                }
            }.navigationBarHidden(true)
        } else {
            StrawView()
        }
    }
}

struct WalkingView_Previews: PreviewProvider {
    static var previews: some View {
        WalkingView()
    }
}

