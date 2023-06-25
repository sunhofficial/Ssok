//
//  ARViewModel.swift
//  Ssok
//
//  Created by CHANG JIN LEE on 2023/05/13.
//

import Foundation
import RealityKit
import ARKit

class ARViewModel: UIViewController, ObservableObject, ARSessionDelegate {
    @Published private var model: ARModel = ARModel()
    @Published var ARFrame: Bool = false
    @Published var ARtoStarw: Bool = false

    var processedblinks: Set<Int> = []
    var blinkCount: Int = 0
    var smileCount: Int = 0
    var blinkStatus: Bool = false
    var smileStatus: Bool = false
    var tongueOutStatus: Bool = false
    var asyncblinkCount: Int = 0
    var asyncsmileCount: Int = 0
    var asyncisblinkCount: Bool = false
    var asyncissmileCount: Bool = false
    var cameraControl: Bool = false

    var arView: ARView {
        model.arView
        }

    var isSmiling: Bool {
        var tempSmile = false
        smileStatus = false
        if model.tongueOut > 0.5 {
            smileStatus = true
            tempSmile = true
        }
        return tempSmile
        }

    func pauseSession() {
        model.arView.session.pause()
    }

    func flipcameraControl() {
        cameraControl.toggle()
    }
    var isBlinking: Bool {
        blinkStatus = false

        if model.blinkLeft > 0.5 || model.blinkRight > 0.5 {
            blinkStatus = true
        }

        return blinkStatus
        }

    var istongueOut: Bool {
        tongueOutStatus = false

        if model.tongueOut > 0.5 {
            tongueOutStatus = true
        }

        return tongueOutStatus
    }

    var getBlinkCount: Int {
        return blinkCount
    }

    func calculateSmileCount() -> String {
        smileCount += 1
        if smileCount > 30 {
            asyncSmileCount += 1
            smileCount = 0
        }
        if asyncSmileCount >= 2 {
            asyncSmileCount = 2
            asyncIsSmileCount = true
        }
      return ""
    }
  
  func calculateBlinkCount() -> String {
        blinkCount += 1
        if blinkCount > 30 {
            asyncBlinkCount += 1
            blinkCount = 0
        }
        if asyncBlinkCount >= 2 {
            asyncBlinkCount = 2
            asyncIsBlinkCount = true
        }
        return ""
    }
  
  func flushCount() -> String {
        smileCount = 0
        blinkCount = 0
        return ""
    }

  func startSessionDelegate() {
      model.arView.session.delegate = self
  
  func session(_ session: ARSession, didUpdate anchors: [ARAnchor]) {
      if let faceAnchor = anchors.first  as? ARFaceAnchor {
          model.update(faceAnchor: faceAnchor)
      }
  }
}
