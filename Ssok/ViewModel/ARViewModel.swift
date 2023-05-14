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
    @Published private var model : ARModel = ARModel()
    
    var processedblinks: Set<Int> = []
    
    var blinkCount: Int = 0
    var blinkStatus: Bool = false
    
    var arView : ARView {
        model.arView
        }
    
    var isSmiling: Bool {
        var tempSmile = false
        if model.smileLeft > 0.3 || model.smileRight > 0.3 {
            tempSmile = true
        }
        return tempSmile
        }
    
    var isBlinking: Bool{
        blinkStatus = false
        
        if model.blinkLeft > 0.5 || model.blinkRight > 0.5 {
            blinkStatus = true
        }
        
        return blinkStatus
        }
        
        var getBlinkCount: Int{
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
