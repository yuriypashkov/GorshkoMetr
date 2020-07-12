//
//  GameScene.swift
//  GorshkoMetr
//
//  Created by Yuriy Pashkov on 6/20/20.
//  Copyright © 2020 Yuriy Pashkov. All rights reserved.
//

import Foundation
import SpriteKit

protocol TransitionDelegate: SKSceneDelegate {
    func dismissVC()
    var score: Int {get set}
}

struct CollisionCategory {
    static let ball: UInt32 = 0x1 << 0
    static let square: UInt32 = 0x1 << 1
}

class GameScene: SKScene {
    
    var testObject: SKShapeNode!
    var testSquare: SKShapeNode!
    let tupleOfRespawn: [(CGFloat, CGFloat)] = [(150,900),(150,700),(1800,700),(1800,900)]
    let arrayOfSquares: [CGPoint] = [CGPoint(x: 400, y: 800), CGPoint(x: 400, y: 400), CGPoint(x: 1520, y: 400), CGPoint(x: 1520, y: 800)]
    
     override func didMove(to view: SKView) {

        // adding physical
        physicsWorld.gravity = CGVector(dx: 0, dy: -9.8)
        physicsWorld.contactDelegate = self
        //adding test ball
        guard let randStartElement = tupleOfRespawn.randomElement() else {return}
        addingTestBall(x: randStartElement.0, y: randStartElement.1)
        
        //adding a test square
        testSquare = SKShapeNode(rect: CGRect(x: -25, y: -25, width: 50, height: 50))
        testSquare.zPosition = 2
        testSquare.fillColor = .systemBlue
        testSquare.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 50, height: 50))
        testSquare.physicsBody?.isDynamic = false
        testSquare.physicsBody?.categoryBitMask = CollisionCategory.square
        testSquare.physicsBody?.contactTestBitMask = CollisionCategory.ball
        testSquare.position = arrayOfSquares.randomElement()!
        testSquare.name = "square"
        self.addChild(testSquare)
        
    }
    
    func addingTestBall(x: CGFloat, y: CGFloat) {
        
        testObject = SKShapeNode(circleOfRadius: 60)
        testObject.zPosition = 2
        testObject.position = CGPoint(x: x, y: y)
        testObject.fillColor = .systemRed
        testObject.physicsBody = SKPhysicsBody(circleOfRadius: 60)
        testObject.physicsBody?.isDynamic = true
        testObject.physicsBody?.mass = 5
        testObject.name = "ball"
        testObject.physicsBody?.categoryBitMask = CollisionCategory.ball
        testObject.physicsBody?.contactTestBitMask = CollisionCategory.square
        self.addChild(testObject)
    }
    
    var currentPosition: CGPoint!
    var currentlyTouching = false
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {return}
        currentPosition = touch.location(in: self)
        let touched = self.atPoint(currentPosition)
        if let name = touched.name {
            switch name {
            case "exitButton":
                removeAllActions()
                removeAllChildren()
                guard let delegate = self.delegate else { return }
                (delegate as! TransitionDelegate).dismissVC()
            case "controlLeftTop":
                testSquare.position = arrayOfSquares[0]
            case "controlLeftBottom":
                testSquare.position = arrayOfSquares[1]
            case "controlRightTop":
                testSquare.position = arrayOfSquares[3]
            case "controlRightBottom":
                testSquare.position = arrayOfSquares[2]
            default:
                currentlyTouching = true
            }
        }
    }
    
    func updateBall() {
        testObject.removeFromParent()
        guard let randElement = tupleOfRespawn.randomElement() else {return}
        addingTestBall(x: randElement.0, y: randElement.1)
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        if testObject.position.y <= 0 {
            updateBall()
        }
    }
    
}

extension GameScene: SKPhysicsContactDelegate {
    func didBegin(_ contact: SKPhysicsContact) {
        let contactMask = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        switch contactMask {
        case CollisionCategory.ball | CollisionCategory.square:
            updateBall()
            guard let delegate = self.delegate else { return }
            (delegate as! TransitionDelegate).score += 1
        default:
            return
        }
    }
}

