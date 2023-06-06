//
//  WalkingCountView.swift
//  Ssok
//
//  Created by 김용주 on 2023/05/13.
//

import SwiftUI
import CoreMotion

struct WalkingCountView: View {
    
    let activityManager = CMMotionActivityManager()
    let pedometer = CMPedometer()
    
    @State var stepcount: Int = 0
    
    var body: some View {
        ZStack {
            Rectangle().fill(.brown).opacity(0.5).frame(width: wid, height: hei/4).ignoresSafeArea()
            Text("\(stepcount)  회").bold()
        }
        .onAppear {
            if CMPedometer.isStepCountingAvailable() {
                self.pedometer.startUpdates(from: Date()) { (date, error) in
                    if error == nil {
                        if let response = date {
                            DispatchQueue.main.async {
                                self.stepcount = Int(truncating: response.numberOfSteps)
                            }
                        }
                    }
                }
            }
        }
    }
}

struct WalkingCountView_Previews: PreviewProvider {
    static var previews: some View {
        WalkingCountView()
    }
}
