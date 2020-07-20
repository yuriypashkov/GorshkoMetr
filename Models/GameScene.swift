
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

    var target: TargetObject!
    
    var testSquare: SKShapeNode!
    
    let arrayOfRespawn: [CGPoint] = [CGPoint(x: 180, y: 900),
                                     CGPoint(x: 180, y: 700),
                                     CGPoint(x: 1700, y: 700),
                                     CGPoint(x: 1700, y: 900),]
    let arrayOfSquares: [CGPoint] = [CGPoint(x: 400, y: 800),
                                     CGPoint(x: 400, y: 400),
                                     CGPoint(x: 1520, y: 400),
                                     CGPoint(x: 1520, y: 800)]
    let arrayOfTargets: [TargetObject] = [TargetObject(imageName: "zombie", reward: 1, mass: 5, restitution: 0.1),
                                          TargetObject(imageName: "skull", reward: 5, mass: 10, restitution: 0.5),
                                          TargetObject(imageName: "bat", reward: 10, mass: 30, restitution: 0.9)]
    
    
     override func didMove(to view: SKView) {

        // adding physical
        physicsWorld.gravity = CGVector(dx: 0, dy: -9.8)
        physicsWorld.contactDelegate = self
        //adding target
        guard let randStartElement = arrayOfRespawn.randomElement() else { return }
        addTarget(x: randStartElement.x, y: randStartElement.y)
        
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
    
    func addTarget(x: CGFloat, y: CGFloat) {
        target = arrayOfTargets.randomElement()
        target.position = CGPoint(x: x, y: y)
        target.physicsBody?.categoryBitMask = CollisionCategory.ball
        target.physicsBody?.contactTestBitMask = CollisionCategory.square
        self.addChild(target)
    }
    
    var currentPosition: CGPoint!
    
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
                return
            }
        }
    }
    
    func updateTarget() {
        target.removeFromParent()
        guard let randElement = arrayOfRespawn.randomElement() else {return}
        addTarget(x: randElement.x, y: randElement.y)
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        if target.position.y <= 0 {
            updateTarget()
        }
    }
    
}

extension GameScene: SKPhysicsContactDelegate {
    func didBegin(_ contact: SKPhysicsContact) {
        let contactMask = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        switch contactMask {
        case CollisionCategory.ball | CollisionCategory.square:
            guard let delegate = self.delegate else { return }
            (delegate as! TransitionDelegate).score += target.reward
            updateTarget()
        default:
            return
        }
    }
}

