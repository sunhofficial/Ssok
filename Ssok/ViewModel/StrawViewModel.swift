//
//  StrawViewModel.swift
//  6Bubbles
//
//  Created by CHANG JIN LEE on 2023/05/04.
//

import Foundation
import CoreMotion

class StrawViewModel: ObservableObject{
    private let motionManger = CMMotionManager()
    private var timer: Timer?
    private var previousgravity = 0
    @Published var currentView: Bool = false
    @Published var isAnimation: Bool = false
    @Published var isDisplay: Bool = false
    @Published var BallNumber: Int = 0
    @Published var nextView: Bool = false
    @Published var progress: Double = 0.0
    var maxProgress: Double {
        if(progress > 0.99){
            return 1
        }
        return min(max(progress, 0.0), 1.0) // 왜 0.3이랑 0.7에서는 1씩 안더해질까
    }
  
    func startupdatingMotion(){
        if motionManger.isDeviceMotionAvailable{
            motionManger.deviceMotionUpdateInterval = 0.2
            timer = Timer.scheduledTimer(withTimeInterval: 0.2, repeats: true){
                [weak self] _ in
                self?.updateProgress()
            }
            motionManger.startDeviceMotionUpdates()}
    }
    private func updateProgress(){
        guard let motionData = motionManger.deviceMotion else { return}
        let gravityX = motionData.gravity.x
        let gravityY = motionData.gravity.y
        let gravityZ = motionData.gravity.z
        var currentGravity = 0
        if gravityX > 0.2 || gravityY > 0.2 || gravityZ > 0.2{
            currentGravity = 1
        }else if gravityY >= -0.2 || gravityX >= -0.2 || gravityZ >= -0.2{
            currentGravity = 0
        }else if gravityX < -0.2 || gravityY < -0.2 || gravityZ < 0.2{
            currentGravity  = 2
        }
        if progress >= 1 {
            timer?.invalidate()
            return
        }
        else if currentGravity != previousgravity {
            progress += 0.1
            previousgravity = currentGravity
        }
    }
}
