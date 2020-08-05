
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
            scoreLabel.text = String(score)
            defaults.set(score, forKey: "scoreKey")
        }
    }
    
    var scoreLabel = SKLabelNode()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scene = GameScene(size: CGSize(width: 1920, height: 1080))
       // scene = GameScene(size: view.frame.size)
        scene.scaleMode = .aspectFit // пока так фиксим проблему разных соотношений сторон на разных мобилах
        scene.anchorPoint = CGPoint(x: 0, y: 0)
        scene.delegate = self as TransitionDelegate
  
        //adding background
        let background = Sprite(named: "gameBackground", x: 0, y: 0, z: 0, size: scene.size)
        scene.addChild(background)
        
        // add exit button
        let exitButton = Sprite(named: "closeButtonMenu", x: 1300, y: 900, z: 1)
        exitButton.name = "exitButton"
        scene.addChild(exitButton)
        
        // add rules button
        
        
        //adding buttons for control
        addingButton(imageName: "button_left_up", name: "controlLeftTop", position: CGPoint(x: 50, y: 250))
        addingButton(imageName: "button_left_down", name: "controlLeftBottom", position: CGPoint(x: 50, y: 50))
        addingButton(imageName: "button_right_up", name: "controlRightTop", position: CGPoint(x: 1700, y: 250))
        addingButton(imageName: "button_right_down", name: "controlRightBottom", position: CGPoint(x: 1700, y: 50))

        //adding test opora1 left top
        Block(position: CGPoint(x: 160, y: 830), rotation: -.pi / 6.5).addTo(parent: scene)

        //adding test opora2 left bottom
        Block(position: CGPoint(x: 210, y: 530), rotation: -.pi / 6.5).addTo(parent: scene)

        //adding test opora3 right bottom
        Block(position: CGPoint(x: 1760, y: 520), rotation: .pi / 6.5).addTo(parent: scene)
        
        //adding test opora4 right top
        Block(position: CGPoint(x: 1760, y: 820), rotation: .pi / 6.5).addTo(parent: scene)
        
        // new blocks
        let leftTopBlock = Sprite(named: "branch_up_left", x: 0, y: 600, z: 2)
        scene.addChild(leftTopBlock)
        
        let leftBottomBlock = Sprite(named: "branch_down_left", x: 0, y: 300, z: 2)
        scene.addChild(leftBottomBlock)
        
        let rightTopBlock = Sprite(named: "branch_up_right", x: 1380, y: 600, z: 2)
        scene.addChild(rightTopBlock)
        
        let rightBottomBlock = Sprite(named: "branch_down_right", x: 1380, y: 300, z: 2)
        scene.addChild(rightBottomBlock)
        
        // get score
        score = defaults.integer(forKey: "scoreKey")
        
        //add scorelabel
        scoreLabel.text = String(score)
        scoreLabel.position = CGPoint(x: 960, y: 930)
        scoreLabel.fontSize = 90
        scoreLabel.fontColor = .systemYellow
        scoreLabel.zPosition = 3
        scoreLabel.fontName = "CyrillicOldEditedbyme-Bold"
        scene.addChild(scoreLabel)
        

        let skView = view as! SKView
        skView.showsFPS = true
        skView.showsNodeCount = true
//        skView.showsPhysics = true
        skView.ignoresSiblingOrder = true
        skView.presentScene(scene)
        
        
    }
    
    func dismissVC() {
        dismiss(animated: true, completion: nil)
    }
    
    func addingButton(imageName: String, name: String, position: CGPoint) {
        let button = Sprite(named: imageName, x: position.x, y: position.y, z: 3)
        button.name = name
        scene.addChild(button)
    }
    
}
