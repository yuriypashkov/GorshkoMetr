
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
    var beerInGame: Int = 0 {
        didSet {
            defaults.set(beerInGame, forKey: "beerInGame")
        }
    }
    var fuckInGame: Int = 0 {
           didSet {
               defaults.set(fuckInGame, forKey: "fuckInGame")
           }
    }
    var mushroomInGame: Int = 0 {
           didSet {
               defaults.set(mushroomInGame, forKey: "mushroomInGame")
           }
    }
    
    //end ach vars

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
    var wolfSound: AVAudioPlayer!
    var mushroomSound: AVAudioPlayer!
    
    var isChekboxChecked = true
    
    var controlLeftTop: Sprite!
    var controlLeftBottom: Sprite!
    var controlRightTop: Sprite!
    var controlRightBottom: Sprite!
    
    var lightningShape: SKShapeNode!
    var twiceLabel: SKLabelNode!
    
     override func didMove(to view: SKView) {
        // listener, следит за отключением фоновой песни при входящем звонке
//        NotificationCenter.default.addObserver(self, selector: #selector(handleInterruption), name: AVAudioSession.interruptionNotification, object: nil)
        
        //play music
        let mainMusicThemePath = Bundle.main.path(forResource: "mainTheme", ofType: "mp3")
        do {
            backgroundMusic = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: mainMusicThemePath!))
            backgroundMusic.numberOfLoops = -1
            backgroundMusic.volume = 0.8
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
        let wolfSoundPath = Bundle.main.path(forResource: "wolf_sound", ofType: "mp3")
        let mushroomSoundPath = Bundle.main.path(forResource: "mushroom_sound", ofType: "mp3")
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
            wolfSound = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: wolfSoundPath!))
            mushroomSound = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: mushroomSoundPath!))
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
        
        //get beer, fuck, mushroom in game
        beerInGame = defaults.integer(forKey: "beerInGame")
        fuckInGame = defaults.integer(forKey: "fuckInGame")
        mushroomInGame = defaults.integer(forKey: "mushroomInGame")
        
        //get checkbox state
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
        
        //reward twice
        let attributes: [NSAttributedString.Key : Any] = [.strokeWidth: -5.0,
                                                          .strokeColor: UIColor.black,
                                                          .foregroundColor: UIColor.red,
                                                          .font: UIFont(name: "CyrillicOldEditedbyme-Bold", size: 75)!]
        let rewardText = NSAttributedString(string: "ВСЕ ОЧКИ х2!", attributes: attributes)
        twiceLabel = SKLabelNode(attributedText: rewardText)
        twiceLabel.isHidden = true
        twiceLabel.zPosition = 3
        twiceLabel.position = CGPoint(x: 1218, y: 1035)
        addChild(twiceLabel)
    }
    
//    deinit {
//        NotificationCenter.default.removeObserver(self, name: AVAudioSession.interruptionNotification, object: nil)
//    }
//    
//    @objc func handleInterruption(notification: Notification) {
//        if notification.name == AVAudioSession.interruptionNotification {
//            print("Interrupt Sound")
//        }
//    }
    
    
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
    
    var isRewardTwice = false
    
    var isButtonSwapped = false
    
    func swapButtons() {
        let tempPositionTop = controlLeftTop.position
        let tempPositionBottom = controlLeftBottom.position
        controlLeftTop.position = controlRightTop.position
        controlLeftBottom.position = controlRightBottom.position
        controlRightTop.position = tempPositionTop
        controlRightBottom.position = tempPositionBottom
        isButtonSwapped = !isButtonSwapped
        mushroomSound.play()
    }
    
    func gorshokUpdate(imageName: String) {
        gorshok.removeFromParent()
        gorshok = Sprite(named: imageName, x: 1218, y: 440, z: 3)
        gorshok.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        addChild(gorshok)
        if isHeroin { gorshokBlink() }
    }
    
    func spawnTargets(frequency: Int) {
        if Int(arc4random()) % 1000 < frequency { // рандом-генератор частоты появления артов
            spawnTargetInstantly()
        }
    }
    
    
    func spawnTargetInstantly() {
        var target: TargetObject
        let randTargetType = TargetType.allCases.randomElement()
        guard let randStartElement = arrayOfRespawn.randomElement() else { return }
        switch randTargetType {
        case .beer:
            target = TargetObject(imageName: "beer", reward: 50, mass: 5, restitution: 0.1, isGoodItem: true, type: .beer)
            if randStartElement.x == 1950 {
                target.zRotation = .pi / 7.0
            } else {
                target.zRotation = -.pi / 7.0
            }
        case .bag:
            target = TargetObject(imageName: "bag", reward: 5, mass: 10, restitution: 0.5, isGoodItem: true, type: .bag)
        case .syringe:
            target = TargetObject(imageName: "syringe", reward: -100, mass: 10, restitution: 0.9, isGoodItem: false, type: .syringe)
        case .fuck:
            target = TargetObject(imageName: "fuck", reward: -15, mass: 15, restitution: 0.5, isGoodItem: false, type: .fuck)
        case .head:
            target = TargetObject(imageName: "head", reward: -10, mass: 20, restitution: 0.7, isGoodItem: false, type: .head)
        case .lightning:
            target = TargetObject(imageName: "lightning", reward: 30, mass: 15, restitution: 0.3, isGoodItem: true, type: .lightning)
        case .meat:
            target = TargetObject(imageName: "meat", reward: 20, mass: 20, restitution: 0.6, isGoodItem: true, type: .meat)
        case .mushroom:
            target = TargetObject(imageName: "mushroom", reward: -40, mass: 15, restitution: 0.8, isGoodItem: false, type: .mushroom)
        case .wolf:
            target = TargetObject(imageName: "wolf", reward: -20, mass: 13, restitution: 0.4, isGoodItem: false, type: .wolf)
        case .book:
            target = TargetObject(imageName: "book", reward: 35, mass: 5, restitution: 0.5, isGoodItem: true, type: .book)
        case .boots:
            target = TargetObject(imageName: "boots", reward: -35, mass: 10, restitution: 0.3, isGoodItem: false, type: .boots)
        case .donkey:
            target = TargetObject(imageName: "donkey", reward: -25, mass: 15, restitution: 0.8, isGoodItem: false, type: .donkey)
        case .melon:
            target = TargetObject(imageName: "melon", reward: -30, mass: 5, restitution: 0.4, isGoodItem: false, type: .melon)
        case .puppet:
            target = TargetObject(imageName: "puppet", reward: 40, mass: 6, restitution: 0.6, isGoodItem: true, type: .puppet)
        case .rum:
            target = TargetObject(imageName: "rum", reward: 45, mass: 5, restitution: 0.7, isGoodItem: true, type: .rum)
        case .skull:
            target = TargetObject(imageName: "skull", reward: 10, mass: 3, restitution: 0.3, isGoodItem: true, type: .skull)
        case .stone:
            target = TargetObject(imageName: "stone", reward: -50, mass: 10, restitution: 0.5, isGoodItem: false, type: .stone)
        case .tooth:
            target = TargetObject(imageName: "tooth", reward: 15, mass: 4, restitution: 0.4, isGoodItem: true, type: .tooth)
        case .none:
            return
        }
        
        target.physicsBody?.categoryBitMask = CollisionCategory.target
        target.physicsBody?.contactTestBitMask = CollisionCategory.square
        target.position = CGPoint(x: randStartElement.x, y: randStartElement.y)
        
        addChild(target)
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
    
    func blinkTwiceLabel() {
        if isRewardTwice {
           let actionOne = SKAction.fadeAlpha(to: 0.3, duration: 0.3)
            let actionTwo = SKAction.fadeAlpha(to: 1.0, duration: 0.3)
            let seq = SKAction.sequence([actionOne, actionTwo])
            twiceLabel.run(SKAction.repeat(seq, count: 8))
        }
    }
    
    var isHeroin = false
    
    func gorshokBlink() {
        if gorshok != nil, isHeroin {
            let actionOne = SKAction.fadeAlpha(to: 0.3, duration: 0.2)
            let actionTwo = SKAction.fadeAlpha(to: 1.0, duration: 0.2)
            let seq = SKAction.sequence([actionOne, actionTwo])
            gorshok.run(SKAction.repeat(seq, count: 4))
        }
    }
    
    
    
    override func update(_ currentTime: TimeInterval) {
        
        let delegate = self.delegate
        let myScore = (delegate as! TransitionDelegate).score
        switch myScore {
        case -10_000..<500:
            spawnTargets(frequency: 5)
        case 500..<2_000:
            spawnTargets(frequency: 10)
        default:
            spawnTargets(frequency: 15)
        }
        
        enumerateTargets()
        // костыль чтоб не было пауз в появлении объектов ловли
        if self.childNode(withName: "target") == nil { spawnTargetInstantly() }
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
    
    var isShowingWolf = false
    
    func addAndBlinkEye(point: CGPoint) {
        let eyeOne = SKShapeNode(circleOfRadius: 4)
        eyeOne.fillColor = .red
        eyeOne.strokeColor = .clear
        eyeOne.position = point
        eyeOne.zPosition = 1
        eyeOne.name = "eyeOne"
        self.addChild(eyeOne)
        let actionOne = SKAction.fadeAlpha(to: 0.3, duration: 0.5)
        let actionTwo = SKAction.fadeAlpha(to: 1.0, duration: 0.5)
        let seq = SKAction.sequence([actionOne,actionTwo])
        eyeOne.run(SKAction.repeat(seq, count: 2))
    }
    
    func showWolfEyes() {
        guard !isShowingWolf else { return }
        isShowingWolf = true
        
        addAndBlinkEye(point: CGPoint(x: 1756, y: 617))
        addAndBlinkEye(point: CGPoint(x: 1774, y: 619))
        //addAndBlinkEye(point: CGPoint(x: 1852, y: 585))
        //addAndBlinkEye(point: CGPoint(x: 1870, y: 587))
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.enumerateChildNodes(withName: "eyeOne") { (node, stop) in
                let eye = node as! SKShapeNode
                eye.removeFromParent()
            }
            self.isShowingWolf = false
        }
        
    }
    
    func showReward(color: UIColor, label: SKLabelNode, reward: Int) {
        let attributes: [NSAttributedString.Key : Any] = [.strokeWidth: -5.0,
                    .strokeColor: UIColor.black,
                    .foregroundColor: color,
                    .font: UIFont(name: "CyrillicOldEditedbyme-Bold", size: 100)!]
        let text = NSAttributedString(string: String(reward), attributes: attributes)
        label.attributedText = text
        self.addChild(label)
        let actionFadeOut = SKAction.fadeOut(withDuration: 0.9)
        let actionMoveUp = SKAction.moveBy(x: 0, y: 150, duration: 0.7)
        let osc = SKAction.oscillation(amplitude: 50, timePeriod: 0.7, midPoint: label.position)
        let group = SKAction.group([actionFadeOut, osc, actionMoveUp])
        label.run(group)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
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
            // посчитаем награду
            var reward = 0
            if isRewardTwice {
                reward = target.reward * 2
            } else {
                reward = target.reward
            }
            // добавим очков за пойманную цель
            guard let delegate = self.delegate else { return }
            (delegate as! TransitionDelegate).score += reward
            let heaven = Sprite(named: "transparent", x: contact.bodyA.node!.position.x, y: contact.bodyA.node!.position.y, z: 10)
            let rewardLabel = SKLabelNode()
            rewardLabel.position = CGPoint(x: contact.bodyA.node!.position.x, y: contact.bodyA.node!.position.y)
            rewardLabel.zPosition = 15
            
            // проверим, не поймали ли нехороший предмет
            if !target.isGoodItem {
                trashItems += 1
                animateAction(imageName: "shit", sprite: heaven)
                wrongObject.play()
                showReward(color: UIColor(red: 0.70, green: 0.05, blue: 0.18, alpha: 1.0), label: rewardLabel, reward: reward)
            } else {
                animateAction(imageName: "heaven", sprite: heaven)
                normalObject.play()
                //showReward(color: UIColor(red: 0.01, green: 0.42, blue: 0.18, alpha: 1.0), label: rewardLabel, reward: target.reward)
                showReward(color: .white, label: rewardLabel, reward: reward)
            }
            
            // проверим тип пойманного объекта и выполним что-нибудь
            switch target.type {
            case .syringe:
                bayanCount += 1
                isHeroin = true
                gorshokBlink()
                testSquare.removeFromParent()
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.6) {
                    self.isHeroin = false
                    self.addChild(self.testSquare)
                }
            case .lightning:
                thunderAndLightning()
            case .beer:
                beerInGame += 1
                beerSound.play()
                if isButtonSwapped { swapButtons() }
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
                isRewardTwice = true
                blinkTwiceLabel()
                twiceLabel.isHidden = false
                DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
                    self.isRewardTwice = false
                    self.twiceLabel.isHidden = true
                }
            case .wolf:
                wolfSound.play()
                showWolfEyes()
            case .mushroom:
                if !isButtonSwapped { swapButtons() }
                mushroomInGame += 1
            case .fuck:
                fuckInGame += 1
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

