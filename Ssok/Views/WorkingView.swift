//
//  WorkingView.swift
//  workingcore
//
//  Created by 김용주 on 2023/05/13.
//

import SwiftUI
import CoreMotion

struct WorkingView: View {
    
    let activityManager = CMMotionActivityManager()
    let pedometer = CMPedometer()
    
    @State var number: Int = 0
    
    var body: some View {
        ZStack {
            Text("\(number) 회")
        }.onAppear {
            if CMPedometer.isStepCountingAvailable() {
                self.pedometer.startUpdates(from: Date()) { (date, error) in
                    if error == nil {
                        if let response = date {
                            DispatchQueue.main.async {
                                self.a = Int(truncating: response.numberOfSteps)
                            }
                        }
                    }
                }
            }
        }
    }
}

struct WorkingView_Previews: PreviewProvider {
    static var previews: some View {
        WorkingView()
    }
}
