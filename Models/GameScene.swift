
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
    var keyClick: AVAudioPlayer!
    var normalObject: AVAudioPlayer!
    var wrongObject: AVAudioPlayer!
    var lightningSound: AVAudioPlayer!
    
    var beerSound: AVAudioPlayer!
    var burpSound: AVAudioPlayer!
    var coinSound: AVAudioPlayer!
    var donkeySound: AVAudioPlayer!
    var headSound: AVAudioPlayer!
    var rumBurpSound: AVAudioPlayer!
    
    var isChekboxChecked = true
    
    var controlLeftTop: Sprite!
    var controlLeftBottom: Sprite!
    var controlRightTop: Sprite!
    var controlRightBottom: Sprite!
    
    var lightningShape: SKShapeNode!
    
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
        //prepare sound
        let keyClickPath = Bundle.main.path(forResource: "keyclick", ofType: "wav")
        let normalObjPath = Bundle.main.path(forResource: "cratepop", ofType: "wav")
        let wrongObjPath = Bundle.main.path(forResource: "wrongObj", ofType: "mp3")
        let lightningSoundPath = Bundle.main.path(forResource: "lightning", ofType: "mp3")
        let beerSoundPath = Bundle.main.path(forResource: "beer_sound", ofType: "mp3")
        let burpSoundPath = Bundle.main.path(forResource: "burp_sound", ofType: "mp3")
        let coinSoundPath = Bundle.main.path(forResource: "coin_sound", ofType: "mp3")
        let donkeySoundPath = Bundle.main.path(forResource: "donkey_sound", ofType: "mp3")
        let headSoundPath = Bundle.main.path(forResource: "head_sound", ofType: "mp3")
        let rumBurpSoundPath = Bundle.main.path(forResource: "rum_burp_sound", ofType: "mp3")
        do {
            keyClick = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: keyClickPath!))
            normalObject = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: normalObjPath!))
            wrongObject = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: wrongObjPath!))
            lightningSound = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: lightningSoundPath!))
            beerSound = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: beerSoundPath!))
            burpSound = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: burpSoundPath!))
            coinSound = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: coinSoundPath!))
            donkeySound = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: donkeySoundPath!))
            headSound = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: headSoundPath!))
            rumBurpSound = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: rumBurpSoundPath!))
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
        
        //enum buttons
        self.enumerateChildNodes(withName: "controlLeftTop") { (node, stop) in self.controlLeftTop = node as? Sprite }
        self.enumerateChildNodes(withName: "controlLeftBottom") { (node, stop) in self.controlLeftBottom = node as? Sprite }
        self.enumerateChildNodes(withName: "controlRightTop") { (node, stop) in self.controlRightTop = node as? Sprite }
        self.enumerateChildNodes(withName: "controlRightBottom") { (node, stop) in self.controlRightBottom = node as? Sprite }
        
        //lightning
        lightningShape = SKShapeNode(rect: CGRect(x: 0, y: 0, width: 2436, height: 1125))
        lightningShape.position = CGPoint(x: 0, y: 0)
        lightningShape.zPosition = 9
        lightningShape.fillColor = .white
        lightningShape.alpha = 0.5
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
                keyClick.play()
                controlLeftTop.pushButtonEffect(scaleDown: 0.9, scaleUp: 1.11, duration: 0.1)
            case "controlLeftBottom":
                testSquare.position = arrayOfSquares[1]
                gorshokUpdate(imageName: "g_down_left")
                keyClick.play()
                controlLeftBottom.pushButtonEffect(scaleDown: 0.9, scaleUp: 1.11, duration: 0.1)
            case "controlRightTop":
                testSquare.position = arrayOfSquares[3]
                gorshokUpdate(imageName: "g_up_right")
                keyClick.play()
                controlRightTop.pushButtonEffect(scaleDown: 0.9, scaleUp: 1.11, duration: 0.1)
            case "controlRightBottom":
                testSquare.position = arrayOfSquares[2]
                gorshokUpdate(imageName: "g_down_right")
                keyClick.play()
                controlRightBottom.pushButtonEffect(scaleDown: 0.9, scaleUp: 1.11, duration: 0.1)
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
    
    func spawnTargets() {
        if Int(arc4random()) % 1000 < 15 { // рандом-генератор частоты появления артов
            var target: TargetObject
            let randTargetType = TargetType.allCases.randomElement()
            switch randTargetType {
            case .beer:
                target = TargetObject(imageName: "beer", reward: 50, mass: 5, restitution: 0.1, isGoodItem: true, type: .beer)
            case .bag:
                target = TargetObject(imageName: "bag", reward: 5, mass: 10, restitution: 0.5, isGoodItem: true, type: .bag)
            case .syringe:
                target = TargetObject(imageName: "syringe", reward: -100, mass: 10, restitution: 0.9, isGoodItem: false, type: .syringe)
            case .fuck:
                target = TargetObject(imageName: "fuck", reward: -10, mass: 15, restitution: 0.5, isGoodItem: false, type: .fuck)
            case .head:
                target = TargetObject(imageName: "head", reward: -10, mass: 20, restitution: 0.7, isGoodItem: false, type: .head)
            case .lightning:
                target = TargetObject(imageName: "lightning", reward: 20, mass: 15, restitution: 0.3, isGoodItem: true, type: .lightning)
            case .meat:
                target = TargetObject(imageName: "meat", reward: 15, mass: 20, restitution: 0.6, isGoodItem: true, type: .meat)
            case .mushroom:
                target = TargetObject(imageName: "mushroom", reward: -20, mass: 15, restitution: 0.8, isGoodItem: false, type: .mushroom)
            case .wolf:
                target = TargetObject(imageName: "wolf", reward: -10, mass: 13, restitution: 0.4, isGoodItem: false, type: .wolf)
            case .book:
                target = TargetObject(imageName: "book", reward: 30, mass: 5, restitution: 0.5, isGoodItem: true, type: .book)
            case .boots:
                target = TargetObject(imageName: "boots", reward: -20, mass: 10, restitution: 0.3, isGoodItem: false, type: .boots)
            case .donkey:
                target = TargetObject(imageName: "donkey", reward: -15, mass: 15, restitution: 0.8, isGoodItem: false, type: .donkey)
            case .melon:
                target = TargetObject(imageName: "melon", reward: -20, mass: 5, restitution: 0.4, isGoodItem: false, type: .melon)
            case .puppet:
                target = TargetObject(imageName: "puppet", reward: 30, mass: 6, restitution: 0.6, isGoodItem: true, type: .puppet)
            case .rum:
                target = TargetObject(imageName: "rum", reward: 40, mass: 5, restitution: 0.7, isGoodItem: true, type: .rum)
            case .skull:
                target = TargetObject(imageName: "skull", reward: 10, mass: 3, restitution: 0.3, isGoodItem: true, type: .skull)
            case .stone:
                target = TargetObject(imageName: "stone", reward: -40, mass: 10, restitution: 0.5, isGoodItem: false, type: .stone)
            case .tooth:
                target = TargetObject(imageName: "tooth", reward: 10, mass: 4, restitution: 0.4, isGoodItem: true, type: .tooth)
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
    
    var isLightning = false
    
    func thunderAndLightning() {
        guard !isLightning else { return }
        self.addChild(lightningShape)
        var timerValue = 0
        isLightning = true
        lightningSound?.play()
        let wait = SKAction.wait(forDuration: 0.1)
        let lightOn = SKAction.run ({
            [unowned self] in
            if timerValue <= 3 {
                timerValue += 1
                self.lightningShape.alpha = 0.5
            } else {
                self.removeAction(forKey: "lightningCountdown")
                self.lightningShape.removeFromParent()
                self.isLightning = false
            }
        })
        let lightOff = SKAction.run {
            self.lightningShape.alpha = 0.0
        }
        let sequence = SKAction.sequence([lightOn, wait, lightOff, wait])
        run(SKAction.repeatForever(sequence), withKey: "lightningCountdown")
    }
    
    func showReward(color: UIColor, label: SKLabelNode, reward: Int) {
        let attributes: [NSAttributedString.Key : Any] = [.strokeWidth: -4.0,
                    .strokeColor: UIColor.black,
                    .foregroundColor: color,
                    .font: UIFont(name: "CyrillicOldEditedbyme-Bold", size: 100)!]
        let text = NSAttributedString(string: String(reward), attributes: attributes)
        label.attributedText = text
        self.addChild(label)
        let actionFadeOut = SKAction.fadeOut(withDuration: 1.0)
        let actionMoveUp = SKAction.moveBy(x: 0, y: 150, duration: 0.7)
        let osc = SKAction.oscillation(amplitude: 50, timePeriod: 0.7, midPoint: label.position)
        let group = SKAction.group([actionFadeOut, osc, actionMoveUp])
        label.run(group)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
            label.removeFromParent()
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
            let rewardLabel = SKLabelNode()
            rewardLabel.position = CGPoint(x: contact.bodyA.node!.position.x, y: contact.bodyA.node!.position.y)
            rewardLabel.zPosition = 15
            
            // проверим, не поймали ли нехороший предмет
            if !target.isGoodItem {
                trashItems += 1
                animateAction(imageName: "shit", sprite: heaven)
                wrongObject.play()
                showReward(color: UIColor(red: 0.70, green: 0.05, blue: 0.18, alpha: 1.0), label: rewardLabel, reward: target.reward)
            } else {
                animateAction(imageName: "heaven", sprite: heaven)
                normalObject.play()
                //showReward(color: UIColor(red: 0.01, green: 0.42, blue: 0.18, alpha: 1.0), label: rewardLabel, reward: target.reward)
                showReward(color: .white, label: rewardLabel, reward: target.reward)
            }
            // проверим тип пойманного объекта и выполним что-нибудь
            switch target.type {
            case .syringe:
                bayanCount += 1
            case .lightning:
                thunderAndLightning()
            case .beer:
                beerSound.play()
            case .meat:
                burpSound.play()
            case .bag:
                coinSound.play()
            case .donkey:
                donkeySound.play()
            case .head:
                headSound.play()
            case .rum:
                rumBurpSound.play()
            default: ()
            }

            // удаляем объект с игровой сцены
            target.removeFromParent()
        default:
            return
        }
    }
}

extension SKAction {
    static func oscillation(amplitude a: CGFloat, timePeriod t: CGFloat, midPoint: CGPoint) -> SKAction {
        let action = SKAction.customAction(withDuration: Double(t)) { node, currentTime in
            let displacement = a * sin(2 * .pi * currentTime / t)
            node.position.x = midPoint.x + displacement
        }
        return action
    }
}

