
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
        let background = Sprite(named: "back", x: 0, y: 0, z: 0, size: scene.size)
        scene.addChild(background)
        
        // add exit button
        let exitButton = SKShapeNode()
        let exitRect = CGRect(x: 0, y: 0, width: 100, height: 100)
        exitButton.path = UIBezierPath(ovalIn: exitRect).cgPath
        exitButton.position = CGPoint(x: 550, y: 900)
        exitButton.fillColor = UIColor.green
        exitButton.zPosition = 1
        exitButton.name = "exitButton"
        
        scene.addChild(exitButton)
        
        //adding buttons for control
        addingButton(name: "controlLeftTop", position: CGPoint(x: 120, y: 300))
        addingButton(name: "controlLeftBottom", position: CGPoint(x: 120, y: 100))
        addingButton(name: "controlRightTop", position: CGPoint(x: 1800, y: 300))
        addingButton(name: "controlRightBottom", position: CGPoint(x: 1800, y: 100))

        //adding test opora1 left top
        Block(position: CGPoint(x: 150, y: 800), rotation: -.pi / 6).addTo(parent: scene)

        //adding test opora2 left bottom
        Block(position: CGPoint(x: 150, y: 500), rotation: -.pi / 4).addTo(parent: scene)

        //adding test opora3 right bottom
        Block(position: CGPoint(x: 1750, y: 500), rotation: .pi / 4).addTo(parent: scene)
        
        //adding test opora4 right top
        Block(position: CGPoint(x: 1750, y: 800), rotation: .pi / 6).addTo(parent: scene)
        
        // get score
        score = defaults.integer(forKey: "scoreKey")
        
        //add scorelabel
        scoreLabel.text = String(score)
        scoreLabel.position = CGPoint(x: 960, y: 930)
        scoreLabel.fontSize = 60
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
    
    func addingButton(name: String, position: CGPoint) {
        let button = SKShapeNode(circleOfRadius: 80)
        button.position = position
        button.fillColor = .yellow
        button.zPosition = 3
        button.name = name
        scene.addChild(button)
    }
    
}
