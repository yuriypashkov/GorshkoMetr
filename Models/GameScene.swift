
import Foundation
import SpriteKit
import AVFoundation

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
    var bayanCount: Int = 0 {
        didSet {
            defaults.set(bayanCount, forKey: "bayanCount")
        }
    }
    var timeInGame: Int = 0 {
        didSet {
            defaults.set(timeInGame, forKey: "timeInGame")
        }
    }

    var testSquare: SKShapeNode!
    
    let arrayOfRespawn: [CGPoint] = [CGPoint(x: 230, y: 990),
                                     CGPoint(x: 200, y: 700),
                                     CGPoint(x: 1950, y: 650),
                                     CGPoint(x: 1950, y: 980),]
    
    let arrayOfSquares: [CGPoint] = [CGPoint(x: 940, y: 650),
                                     CGPoint(x: 940, y: 370),
                                     CGPoint(x: 1500, y: 380),
                                     CGPoint(x: 1470, y: 650)]
    
    var gorshok: Sprite!
    var startTime = 0
    
    var backgroundMusic: AVAudioPlayer!
    var isChekboxChecked = true
    
     override func didMove(to view: SKView) {
        //play music
        let mainMusicThemePath = Bundle.main.path(forResource: "lesnik_game_2", ofType: "mp3")
        do {
            backgroundMusic = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: mainMusicThemePath!))
            backgroundMusic.numberOfLoops = -1
            backgroundMusic.play()
        } catch  {
            print(error)
        }
        
        // adding physical
        physicsWorld.gravity = CGVector(dx: 0, dy: -9.8)
        physicsWorld.contactDelegate = self
        
        //adding a square for collision
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
        
        //get bayanCount
        bayanCount = defaults.integer(forKey: "bayanCount")
        
        //get timeInGame
        timeInGame = defaults.integer(forKey: "timeInGame")
        startTime = Int(Date().timeIntervalSince1970)
        
        //get checkbox state ГАЛКУ СДЕЛАТЬ БОЛЬШЕ
        isChekboxChecked = defaults.bool(forKey: "isCheckboxChecked")
        
        //первый запуск приложения, галочка стоит по-умолчанию
        if defaults.integer(forKey: "launchCount") <= 1 { isChekboxChecked = true }
        
        if isChekboxChecked {
            scene?.isPaused = true
            rulesView = RulesView(size: CGSize(width: 2436, height: 1125))
            rulesView.addTo(parent: scene!)
        }
        
        //add gorshok
        gorshok = Sprite(named: "g_down_left", x: 1218, y: 440, z: 3)
        gorshok.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.addChild(gorshok)

    }
    
    
    var currentPosition: CGPoint!
    var rulesView: RulesView!
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {return}
        currentPosition = touch.location(in: self)
        let touched = self.atPoint(currentPosition)
        if let name = touched.name {
            switch name {
            case "exitButton":
                timeInGame += Int(Date().timeIntervalSince1970) - startTime
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
            case "rulesButton":
                scene?.isPaused = true
                rulesView = RulesView(size: CGSize(width: 2436, height: 1125))
                
                if isChekboxChecked { rulesView.checkbox.alpha = 1.0 }
                else { rulesView.checkbox.alpha = 0.0 }
                
                rulesView.addTo(parent: scene!)
            case "gameCloseRules":
                scene?.isPaused = false
                rulesView.removeThis()
            case "gameCheckbox":
                isChekboxChecked = !isChekboxChecked
                if isChekboxChecked { rulesView.checkbox.alpha = 1.0 } else { rulesView.checkbox.alpha = 0.0 }
                defaults.set(isChekboxChecked, forKey: "isCheckboxChecked")
            default:
                return
            }
        }
    }
    
    func gorshokUpdate(imageName: String) {
        gorshok.removeFromParent()
        gorshok = Sprite(named: imageName, x: 1218, y: 440, z: 3)
        gorshok.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        //gorshok.animateGorshok(x: 10, y: 10, duration: 0.9)
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
        // new
        case book
        case boots
        case donkey
        case melon
        case puppet
        case rum
        case skull
        case stone
        case tooth
    }
    
    func spawnTargets() {
        if Int(arc4random()) % 1000 < 15 { // рандом-генератор частоты появления артов
            var target: TargetObject
            let randTargetType = typeOfTargets.allCases.randomElement()
            switch randTargetType {
            case .beer:
                target = TargetObject(imageName: "beer", reward: 10, mass: 5, restitution: 0.1, isGoodItem: true)
            case .bag:
                target = TargetObject(imageName: "bag", reward: 5, mass: 10, restitution: 0.5, isGoodItem: true)
            case .syringe:
                target = TargetObject(imageName: "syringe", reward: -100, mass: 10, restitution: 0.9, isGoodItem: false, isBayan: true)
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
            case .book:
                target = TargetObject(imageName: "book", reward: 30, mass: 5, restitution: 0.5, isGoodItem: true)
            case .boots:
                target = TargetObject(imageName: "boots", reward: 20, mass: 10, restitution: 0.3, isGoodItem: true)
            case .donkey:
                target = TargetObject(imageName: "donkey", reward: -15, mass: 15, restitution: 0.8, isGoodItem: false)
            case .melon:
                target = TargetObject(imageName: "melon", reward: -20, mass: 5, restitution: 0.4, isGoodItem: false)
            case .puppet:
                target = TargetObject(imageName: "puppet", reward: -30, mass: 6, restitution: 0.6, isGoodItem: false)
            case .rum:
                target = TargetObject(imageName: "rum", reward: 30, mass: 5, restitution: 0.7, isGoodItem: true)
            case .skull:
                target = TargetObject(imageName: "skull", reward: 10, mass: 3, restitution: 0.3, isGoodItem: true)
            case .stone:
                target = TargetObject(imageName: "stone", reward: -40, mass: 10, restitution: 0.5, isGoodItem: false)
            case .tooth:
                target = TargetObject(imageName: "tooth", reward: 10, mass: 4, restitution: 0.4, isGoodItem: true)
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
    
    func animateAction(imageName: String, sprite: Sprite) {
        let textureArray = [SKTexture(imageNamed: "\(imageName)_1"), SKTexture(imageNamed: "\(imageName)_2"), SKTexture(imageNamed: "\(imageName)_3")]
        let action = SKAction.animate(with: textureArray, timePerFrame: 0.1, resize: true, restore: false)
        scene?.addChild(sprite)
        sprite.run(action)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            sprite.removeFromParent()
        }
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
            let heaven = Sprite(named: "transparent", x: contact.bodyA.node!.position.x, y: contact.bodyA.node!.position.y, z: 10)
            // проверим, не поймали ли нехороший предмет
            if !target.isGoodItem {
                trashItems += 1
                animateAction(imageName: "shit", sprite: heaven)
            } else {
                animateAction(imageName: "heaven", sprite: heaven)
            }
            // проверим не поймали ли баян
            if target.isBayan { bayanCount += 1 }
            // удаляем объект с игровой сцены
            target.removeFromParent()
        default:
            return
        }
    }
}

