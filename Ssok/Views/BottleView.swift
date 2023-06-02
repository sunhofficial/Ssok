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

class Bottle: SKScene, SKPhysicsContactDelegate {

    private var motionState = 0
    private var motionManager: CMMotionManager?
    private var pearls = ["Pearl1", "Pearl2"]
    private let leftBorder = SKShapeNode()
    private let leftBottom = SKShapeNode()
    private let rightBorder = SKShapeNode()
    private let rightBottom = SKShapeNode()

    override func didMove(to view: SKView) {
        self.backgroundColor = .clear
        view.allowsTransparency = true
        physicsWorld.contactDelegate = self

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

        setPhysicsBody(setNode: leftBorder)
        leftBorder.zRotation = .pi/45
        leftBorder.position = CGPoint(x: frame.midX-120, y: frame.midY)
        addChild(leftBorder)

        setPhysicsBody(setNode: leftBorder)
        leftBottom.zRotation = .pi/3.0
        leftBottom.position = CGPoint(x: frame.midX, y: frame.midY-243)
        addChild(leftBottom)

        setPhysicsBody(setNode: leftBorder)
        rightBorder.zRotation = -.pi/45
        rightBorder.position = CGPoint(x: frame.midX + 120, y: frame.midY)
        addChild(rightBorder)

        setPhysicsBody(setNode: leftBorder)
        rightBottom.zRotation = -.pi/3.0
        rightBottom.position = CGPoint(x: frame.midX, y: frame.midY-243)
        addChild(rightBottom)

        let pearlRadius = 20.0

        for xRange in stride(from: 200, to: 300, by: pearlRadius) {
            for yRange in stride(from: 150, to: 200, by: pearlRadius) {
                let pearlType = pearls.randomElement()!
//                let pearl = Pearls(imageNamed: pearlType)
                let pearl = SKSpriteNode(imageNamed: pearlType)
                pearl.position = CGPoint(x: xRange, y: yRange)
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
        motionManager = CMMotionManager()
        motionManager?.startAccelerometerUpdates()
    }
    override func update(_ currentTime: TimeInterval) {
        if let accelerometerData = motionManager?.accelerometerData {
            physicsWorld.gravity = CGVector(
                dx: accelerometerData.acceleration.x,
                dy: accelerometerData.acceleration.y * 10)

            if accelerometerData.acceleration.x > 0.5
                || accelerometerData.acceleration.x < -0.5
                || accelerometerData.acceleration.y > 0.2 {
                motionState = 1
            } else {
                motionState = 0
            }
        }

    }
    func didBegin(_ contact: SKPhysicsContact) {
        if contact.bodyA.node?.name == "ball" {
            if motionState == 1 {
                HapticManager.instance.impact(style: .medium)
            }
        }
    }
    func setPhysicsBody(setNode: SKShapeNode) {
        setNode.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 1, height: frame.height))
        setNode.physicsBody?.affectedByGravity = false
        setNode.physicsBody?.isDynamic = false
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
