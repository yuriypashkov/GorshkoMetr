
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
    
    let defaults = UserDefaults.standard
    
    // achiviments vars
    var itemsLost: Int = 0 {
        didSet {
            defaults.set(itemsLost, forKey: "itemsLost")
        }
    }
    var trashItems: Int = 0 {
        didSet {
            defaults.set(trashItems, forKey: "trashItems")
        }
        
    }

    var target: TargetObject!
    
    var testSquare: SKShapeNode!
    
    let arrayOfRespawn: [CGPoint] = [CGPoint(x: 180, y: 900),
                                     CGPoint(x: 180, y: 700),
                                     CGPoint(x: 1700, y: 700),
                                     CGPoint(x: 1700, y: 900),]
    let arrayOfSquares: [CGPoint] = [CGPoint(x: 650, y: 650),
                                     CGPoint(x: 650, y: 400),
                                     CGPoint(x: 1280, y: 380),
                                     CGPoint(x: 1250, y: 650)]
    let arrayOfTargets: [TargetObject] = [TargetObject(imageName: "zombie", reward: 1, mass: 5, restitution: 0.1, isGoodItem: true),
                                          TargetObject(imageName: "skull", reward: 5, mass: 10, restitution: 0.5, isGoodItem: true),
                                          TargetObject(imageName: "bat", reward: -10, mass: 30, restitution: 0.9, isGoodItem: false)]
    
    var gorshok: Sprite!
    
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
        testSquare.position = arrayOfSquares[1]
        testSquare.name = "square"
        self.addChild(testSquare)
        
        //get itemsLost
        itemsLost = defaults.integer(forKey: "itemsLost")
        
        //get trashItems
        trashItems = defaults.integer(forKey: "trashItems")
        
        //add gorshok
        gorshok = Sprite(named: "g_down_left", x: 960, y: 440, z: 3)
        gorshok.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.addChild(gorshok)
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
                gorshokUpdate(imageName: "g_up_left")
            case "controlLeftBottom":
                testSquare.position = arrayOfSquares[1]
                gorshokUpdate(imageName: "g_down_left")
            case "controlRightTop":
                testSquare.position = arrayOfSquares[3]
                gorshokUpdate(imageName: "g_up_right")
            case "controlRightBottom":
                testSquare.position = arrayOfSquares[2]
                gorshokUpdate(imageName: "g_down_right")
            default:
                return
            }
        }
    }
    
    func gorshokUpdate(imageName: String) {
        gorshok.removeFromParent()
        gorshok = Sprite(named: imageName, x: 960, y: 440, z: 3)
        gorshok.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        addChild(gorshok)
    }
    
    func updateTarget() {
        target.removeFromParent()
        guard let randElement = arrayOfRespawn.randomElement() else {return}
        addTarget(x: randElement.x, y: randElement.y)
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        if target.position.y <= 0 {
            if target.isGoodItem {
                itemsLost += 1
            }
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
            if !target.isGoodItem {
                trashItems += 1
            }
            updateTarget()
        default:
            return
        }
    }
}

