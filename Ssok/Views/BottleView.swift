//
//  BottleView.swift
//  6Bubbles
//
//  Created by CHANG JIN LEE on 2023/05/04.
//

import SwiftUI

import CoreMotion
import SpriteKit

struct BottleView: View {

    var scene = Bottle(size: CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
    var body: some View {
        ZStack {
            SpriteView(
                scene: scene,
                options: [.allowsTransparency],
                shouldRender: {_ in return true}
            )
            .ignoresSafeArea().frame(width: wid, height: hei).aspectRatio(contentMode: .fit).offset(y: 17)
        }
        .ignoresSafeArea(.all)
    }
}

struct BottleView_Previews: PreviewProvider {

    static var previews: some View {
        BottleView()
    }
}

struct ColType {
    static let ball: UInt32 = 0x1 << 0
    static let wall: UInt32 = 0x1 << 1
}

class Pearls: SKSpriteNode {}

class Bottle: SKScene, SKPhysicsContactDelegate {

    var motionstate = 0
    var motionmanager: CMMotionManager?
    var pearls = ["Pearl1", "Pearl2"]
    let leftborder = SKShapeNode()
    let leftbottom = SKShapeNode()
    let rightborder = SKShapeNode()
    let rightbottom = SKShapeNode()

    override func didMove(to view: SKView) {
        self.backgroundColor = .clear
        view.allowsTransparency = true
        physicsWorld.contactDelegate = self

        let cup = SKSpriteNode(imageNamed: "cupanddrinks")
        cup.alpha = 0
        cup.position = CGPoint(x: frame.midX, y: 303)
        addChild(cup)

        let vector = SKSpriteNode(imageNamed: "Vector 7")
        vector.alpha = 0
        vector.physicsBody = SKPhysicsBody(edgeLoopFrom: vector.frame)
        vector.position = CGPoint(x: frame.midX, y: 283)
        vector.physicsBody?.affectedByGravity = false
        vector.physicsBody?.categoryBitMask = ColType.wall
        vector.physicsBody?.collisionBitMask = ColType.ball
        vector.physicsBody?.contactTestBitMask = ColType.ball
        vector.physicsBody?.isDynamic = false
        addChild(vector)

        leftborder.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 1, height: frame.height))
        leftborder.physicsBody?.affectedByGravity = false
        leftborder.zRotation = .pi/52
        leftborder.position = CGPoint(x: frame.midX/3.0, y: frame.midY)
        leftborder.physicsBody?.isDynamic = false
        addChild(leftborder)

        leftbottom.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 1, height: frame.height))
        leftbottom.physicsBody?.affectedByGravity = false
        leftbottom.zRotation = .pi/3.0
        leftbottom.position = CGPoint(x: frame.midX, y: frame.height/15)
        leftbottom.physicsBody?.isDynamic = false
        addChild(leftbottom)

        rightborder.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 1, height: frame.height))
        rightborder.physicsBody?.affectedByGravity = false
        rightborder.zRotation = -.pi/45
        rightborder.position = CGPoint(x: ( frame.maxX-frame.midX/3), y: frame.midY)
        rightborder.physicsBody?.isDynamic = false
        addChild(rightborder)

        rightbottom.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 1, height: frame.height))
        rightbottom.physicsBody?.affectedByGravity = false
        rightbottom.zRotation = -.pi/3.0
        rightbottom.position = CGPoint(x: (frame.maxX-frame.midX), y: frame.height/15)
        rightbottom.physicsBody?.isDynamic = false
        addChild(rightbottom)

        let pearlRadius = 20.0

        for i in stride(from: 200, to: 300, by: pearlRadius) {
            for j in stride(from: 150, to: 200, by: pearlRadius) {

                let pearlType = pearls.randomElement()!
                let pearl = Pearls(imageNamed: pearlType)
                pearl.position = CGPoint(x: i, y: j)
                pearl.name = "ball"
                pearl.anchorPoint = CGPoint(x: 0.5, y: 0.5)
                pearl.physicsBody = SKPhysicsBody(circleOfRadius: pearlRadius)
                pearl.physicsBody?.allowsRotation = true
                pearl.physicsBody?.restitution = 0.3
                pearl.physicsBody?.categoryBitMask = ColType.ball
                pearl.physicsBody?.collisionBitMask = ColType.wall | ColType.ball
                pearl.physicsBody?.contactTestBitMask = ColType.wall | ColType.ball
                addChild(pearl)

            }
        }

        let cuphead = SKSpriteNode(imageNamed: "Cuphead")
        cuphead.position = CGPoint(x: frame.midX, y: frame.maxY-323)
        cuphead.anchorPoint = CGPoint(x: 0.5, y: 1)
        addChild(cuphead)

        motionmanager = CMMotionManager()
        motionmanager?.startAccelerometerUpdates()
    }

    override func update(_ currentTime: TimeInterval) {
        if let accelerometerData = motionmanager?.accelerometerData {
            physicsWorld.gravity = CGVector(dx: accelerometerData.acceleration.x * 20, dy: accelerometerData.acceleration.y * 10)

            if accelerometerData.acceleration.x > 0.5 || accelerometerData.acceleration.x < -0.5 || accelerometerData.acceleration.y > 0.2 {
                motionstate = 1
            } else {
                motionstate = 0
            }
        }

    }

    func didBegin(_ contact: SKPhysicsContact) {
        if contact.bodyA.node?.name == "ball" {
            if motionstate == 1 {
                HapticManager.instance.impact(style: .medium)
            }
        }
    }
}

class HapticManager {
    static let instance = HapticManager()
    private init() {}

    func impact(style: UIImpactFeedbackGenerator.FeedbackStyle) {
        let generator = UIImpactFeedbackGenerator(style: style)
        generator.impactOccurred()
    }
}
