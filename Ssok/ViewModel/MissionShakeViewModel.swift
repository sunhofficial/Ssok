//
//  MissionPedometerViewModel.swift
//  Ssok
//
//  Created by 김용주 on 2023/07/02.
//

import CoreMotion
import SwiftUI

class MissionShakeViewModel: ObservableObject {
    let motionManager = CMMotionManager()
    @Published var gravityX: Double = 0
    @Published var gravityY: Double = 0
    @Published var gravityZ: Double = 0
    @Published var currentGravity = 0
    @Published var previousGravity = 0
    @Published var stepCount: Float = 0
    @Published var isMore: Int = 0
    @Published var progressColor: Color = Color("Progress_first")
    
    func startUpdate(_ goalCount: String) {
        if motionManager.isDeviceMotionAvailable {
            motionManager.deviceMotionUpdateInterval = 0.2
            motionManager.startDeviceMotionUpdates(to: OperationQueue.main) { data, _ in
                self.gravityX = data?.gravity.x ?? 0
                
                self.checkRotation()
                
                self.countUp(goalCount)
            }
        }
    }
    
    func checkRotation() {
        if self.gravityX > 0.15 || self.gravityY > 0.15 || self.gravityZ > 0.15 {
            self.currentGravity = 1
        } else if abs(self.gravityX) <= 0.15 &&
                    abs(self.gravityY) <= 0.15 &&
                    abs(self.gravityZ) <= 0.15 {
            self.currentGravity = 0
        } else if self.gravityX < -0.15 || self.gravityY < -0.15 || self.gravityZ < 0.15 {
            self.currentGravity = 2
        }
    }
    
    func countUp(_ goalCount:String) {
        if self.currentGravity != self.previousGravity {
            let targetCount: Float = (goalCount == "40.0" ? 40.0 : 10.0)
            if self.stepCount != targetCount {
                self.stepCount += 1.0
            } else {
                self.motionManager.stopDeviceMotionUpdates()
            }
            self.previousGravity = self.currentGravity
        } else if self.previousGravity != 0 {
            self.previousGravity = self.currentGravity
        }
    }
}
