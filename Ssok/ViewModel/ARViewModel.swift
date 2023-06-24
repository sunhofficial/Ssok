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

    var blinkCount: Int = 0
    var smileCount: Int = 0
    var blinkStatus: Bool = false
    var smileStatus: Bool = false
    var tongueOutStatus: Bool = false
    var asyncBlinkCount: Int = 0
    var asyncSmileCount: Int = 0
    var asyncIsBlinkCount: Bool = false
    var asyncIsSmileCount: Bool = false

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

    func startSessionDelegate() {
        model.arView.session.delegate = self
    }

    func session(_ session: ARSession, didUpdate anchors: [ARAnchor]) {
        if let faceAnchor = anchors.first  as? ARFaceAnchor {
            model.update(faceAnchor: faceAnchor)
        }
    }
}
