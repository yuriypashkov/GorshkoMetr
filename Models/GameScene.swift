
import Foundation
import SpriteKit

protocol TransitionDelegate: SKSceneDelegate {
    func dismissVC()
    var score: Int {get set}
}

struct CollisionCategory {
    static let target: UInt32 = 0x1 << 0
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

    //var target: TargetObject!
    
    var testSquare: SKShapeNode!
    
    let arrayOfRespawn: [CGPoint] = [CGPoint(x: 180, y: 900),
                                     CGPoint(x: 180, y: 700),
                                     CGPoint(x: 1700, y: 700),
                                     CGPoint(x: 1700, y: 900),]
    
    let arrayOfSquares: [CGPoint] = [CGPoint(x: 650, y: 650),
                                     CGPoint(x: 650, y: 400),
                                     CGPoint(x: 1280, y: 380),
                                     CGPoint(x: 1250, y: 650)]
    
    var gorshok: Sprite!
    
     override func didMove(to view: SKView) {

        // adding physical
        physicsWorld.gravity = CGVector(dx: 0, dy: -9.8)
        physicsWorld.contactDelegate = self
        
        //adding a test square
        testSquare = SKShapeNode(rect: CGRect(x: -25, y: -25, width: 50, height: 50))
        testSquare.zPosition = 2
        testSquare.fillColor = .clear
        testSquare.strokeColor = .clear
        testSquare.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 50, height: 50))
        testSquare.physicsBody?.isDynamic = false
        testSquare.physicsBody?.categoryBitMask = CollisionCategory.square
        testSquare.physicsBody?.contactTestBitMask = CollisionCategory.target
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
    
    enum typeOfTargets: CaseIterable {
        case beer
        case bag
        case syringe
        case fuck
        case head
        case lightning
        case meat
        case mushroom
        case wolf
    }
    
    func spawnTargets() {
        if Int(arc4random()) % 1000 < 10 { // рандом-генератор частоты появления артов
            var target: TargetObject
            let randTargetType = typeOfTargets.allCases.randomElement()
            switch randTargetType {
            case .beer:
                target = TargetObject(imageName: "beer", reward: 10, mass: 5, restitution: 0.1, isGoodItem: true)
            case .bag:
                target = TargetObject(imageName: "bag", reward: 5, mass: 10, restitution: 0.5, isGoodItem: true)
            case .syringe:
                target = TargetObject(imageName: "syringe", reward: -100, mass: 10, restitution: 0.9, isGoodItem: false)
            case .fuck:
                target = TargetObject(imageName: "fuck", reward: -10, mass: 15, restitution: 0.5, isGoodItem: false)
            case .head:
                target = TargetObject(imageName: "head", reward: 10, mass: 20, restitution: 0.7, isGoodItem: true)
            case .lightning:
                target = TargetObject(imageName: "lightning", reward: 20, mass: 15, restitution: 0.3, isGoodItem: true)
            case .meat:
                target = TargetObject(imageName: "meat", reward: 1, mass: 20, restitution: 0.6, isGoodItem: true)
            case .mushroom:
                target = TargetObject(imageName: "mushroom", reward: -20, mass: 15, restitution: 0.8, isGoodItem: false)
            case .wolf:
                target = TargetObject(imageName: "wolf", reward: 10, mass: 13, restitution: 0.4, isGoodItem: true)
            case .none:
                return
            }
            
            target.physicsBody?.categoryBitMask = CollisionCategory.target
            target.physicsBody?.contactTestBitMask = CollisionCategory.square
            guard let randStartElement = arrayOfRespawn.randomElement() else { return }
            target.position = CGPoint(x: randStartElement.x, y: randStartElement.y)
            
            addChild(target)
        }
    }
    
    func enumerateTargets() {
        self.enumerateChildNodes(withName: "target") { (node, stop) in
            let target = node as! TargetObject
            self.targetDelete(target: target)
        }
    }
    
    func targetDelete(target: TargetObject) {
        if target.position.y < 20 {
            if target.isGoodItem {
                itemsLost += 1
            }
            target.removeFromParent()
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        spawnTargets()
        enumerateTargets()
    }
    
}

extension GameScene: SKPhysicsContactDelegate {
    func didBegin(_ contact: SKPhysicsContact) {
        let contactMask = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        switch contactMask {
        case CollisionCategory.target | CollisionCategory.square:

            let target = contact.bodyB.node as! TargetObject
            // добавим очков за пойманную цель
            guard let delegate = self.delegate else { return }
            (delegate as! TransitionDelegate).score += target.reward
            // проверим, не поймали ли нехороший предмет
            if !target.isGoodItem {
                    trashItems += 1
            }
            // удаляем объект с игровой сцены
            target.removeFromParent()

        default:
            return
        }
    }
}

