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
    @Published var ARFrame: Bool = false
    @Published var ARtoStarw: Bool = false
    
    var processedblinks: Set<Int> = []
    
    var blinkCount: Int = 0
    var smileCount: Int = 0
    var blinkStatus: Bool = false
    var smileStatus: Bool = false
    
    var asyncblinkCount: Int = 0
    var asyncsmileCount: Int = 0
    var asyncisblinkCount: Bool = false
    var asyncissmileCount: Bool = false
    
    var cameraControl: Bool = false
    
    var arView : ARView {
        model.arView
        }
    
    var isSmiling: Bool {
        var tempSmile = false
        smileStatus = false
        if model.smileLeft > 0.3 || model.smileRight > 0.3 {
            smileStatus = true
            tempSmile = true
        }
        return tempSmile
        }
    
    func pauseSession(){
        model.arView.session.pause()
    }
    
    func flipcameraControl(){
        cameraControl.toggle()
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
