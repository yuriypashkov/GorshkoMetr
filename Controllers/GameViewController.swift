
import UIKit
import SpriteKit

class GameViewController: UIViewController, TransitionDelegate {

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .landscapeRight
    }
    
    let defaults = UserDefaults.standard
    
    var scene = GameScene()
    var score: Int = 0 {
        didSet {
            scoreLabel.text = getNewScore(newScore: score)
            defaults.set(score, forKey: "scoreKey")
        }
    }
    
    var scoreLabel = SKLabelNode()
    
    func getNewScore(newScore: Int) -> String {
        let formatter = NumberFormatter()
        let number = NSNumber(value: newScore)
        formatter.minimumIntegerDigits = 7
        if let resultScore = formatter.string(from: number) {
            return resultScore
        }
        return ""
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //scene = GameScene(size: CGSize(width: 1920, height: 1080))
        scene = GameScene(size: CGSize(width: 2436, height: 1125))
        scene.scaleMode = .aspectFill // пока так фиксим проблему разных соотношений сторон на разных мобилах
        scene.anchorPoint = CGPoint(x: 0, y: 0)
        scene.delegate = self as TransitionDelegate
  
        //adding background
        let background = Sprite(named: "gameBackGroundTwo", x: 0, y: 0, z: 0, size: scene.size)
        scene.addChild(background)
        
        // add exit button
        let exitButton = Sprite(named: "closeNew", x: scene.size.width / 2 + 350, y: 900, z: 1)
        exitButton.name = "exitButton"
        exitButton.setScale(0.8)
        scene.addChild(exitButton)
        
        // add rules button
        let rulesButton = Sprite(named: "infoTwo", x: scene.size.width / 2 - 500, y: 900, z: 1)
        rulesButton.name = "rulesButton"
        rulesButton.setScale(0.8)
        scene.addChild(rulesButton)
        
        //adding buttons for control
        
        //if UIScreen.main.bounds.width < 895 {
            addFourButtons(onWidth: 300, tab: 1650)
//        } else {
//            addFourButtons(onWidth: 100, tab: 2050)
//        }
        
        //adding test opora1 left top
        Block(position: CGPoint(x: 380, y: 830), rotation: -.pi / 7.0).addTo(parent: scene)

        //adding test opora2 left bottom
        Block(position: CGPoint(x: 450, y: 530), rotation: -.pi / 7.0).addTo(parent: scene)

        //adding test opora3 right bottom
        Block(position: CGPoint(x: 1980, y: 520), rotation: .pi / 7.0).addTo(parent: scene)
        
        //adding test opora4 right top
        Block(position: CGPoint(x: 2030, y: 820), rotation: .pi / 7.0).addTo(parent: scene)
        
        // new blocks
        let leftTopBlock = Sprite(named: "branch_left_topNEW", x: 0, y: 590, z: 2)
        leftTopBlock.zRotation = .pi / 150
        scene.addChild(leftTopBlock)
        
        let leftBottomBlock = Sprite(named: "branch_left_bottomNEW", x: 0, y: 300, z: 2)
        leftBottomBlock.zRotation = .pi / 150
        scene.addChild(leftBottomBlock)
        
        let rightTopBlock = Sprite(named: "branch_right_topNEW", x: 1655, y: 615, z: 2)
        rightTopBlock.zRotation = -.pi / 120
        scene.addChild(rightTopBlock)
        
        let rightBottomBlock = Sprite(named: "branch_right_bottomNEW", x: 1600, y: 315, z: 2)
        rightBottomBlock.zRotation = -.pi / 90
        scene.addChild(rightBottomBlock)
        
        // get score
        score = defaults.integer(forKey: "scoreKey")
        
        //add scorelabel
        //scoreLabel.text = String(score)
        scoreLabel.position = CGPoint(x: scene.size.width / 2, y: 930)
        scoreLabel.fontSize = 96
        scoreLabel.fontColor = .systemYellow
        scoreLabel.zPosition = 3
        scoreLabel.fontName = "CyrillicOldEditedbyme-Bold"
        scene.addChild(scoreLabel)
        

        let skView = view as! SKView
        //skView.showsFPS = true
        //skView.showsNodeCount = true
        //skView.showsPhysics = true
        skView.ignoresSiblingOrder = true
        skView.presentScene(scene)
        
        
    }
    
    func addFourButtons(onWidth: CGFloat, tab: CGFloat) {
        addingButton(imageName: "button_left_up", name: "controlLeftTop", position: CGPoint(x: onWidth, y: 270))
        addingButton(imageName: "button_left_down", name: "controlLeftBottom", position: CGPoint(x: onWidth, y: 30))
        addingButton(imageName: "button_right_up", name: "controlRightTop", position: CGPoint(x: onWidth + tab, y: 270))
        addingButton(imageName: "button_right_down", name: "controlRightBottom", position: CGPoint(x: onWidth + tab, y: 30))
    }
    
    func dismissVC() {
        dismiss(animated: true, completion: nil)
    }
    
    func addingButton(imageName: String, name: String, position: CGPoint) {
        let button = Sprite(named: imageName, x: position.x, y: position.y, z: 10)
        button.name = name
        button.setScale(1.1)
        scene.addChild(button)
    }
    
}
