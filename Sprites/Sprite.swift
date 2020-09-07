
import SpriteKit

class Sprite: SKSpriteNode {
    
    var spritePosition: SpritePosition!
    var currentImageName: String!
    
    init(named: String, x: CGFloat, y: CGFloat, z: CGFloat) {
        let texture = SKTexture(imageNamed: named)
        super.init(texture: texture, color: UIColor.clear, size: texture.size())
        self.position = CGPoint(x: x, y: y)
        self.anchorPoint = CGPoint(x: 0, y: 0)
        self.zPosition = z
        self.name = named
        currentImageName = named
    }
    
    convenience init(named: String, x: CGFloat, y: CGFloat, z: CGFloat, size: CGSize) {
        self.init(named: named, x: x, y: y, z: z)
        self.size = size
    }
    
    convenience init(named: String, x: CGFloat, y: CGFloat, z: CGFloat, spritePosition: SpritePosition) {
        self.init(named: named, x: x, y: y, z: z)
        self.spritePosition = spritePosition
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

enum SpritePosition {
    case rightTop
    case rightBottom
    case leftTop
    case leftBottom
}

extension Sprite {
//    func animateGorshok(x: CGFloat, y: CGFloat, duration: TimeInterval) {
//        let firstAction = SKAction.moveBy(x: -x, y: y, duration: duration)
//        let secondAction = SKAction.moveBy(x: x, y: -y, duration: duration)
//        let actionGroup = SKAction.sequence([firstAction, secondAction])
//        let newSequence = SKAction.repeatForever(actionGroup)
//        self.run(newSequence)
//    }
    
    func pushButtonEffect(scaleDown: CGFloat, scaleUp: CGFloat, duration: Double) {
        let scaleDwn = SKAction.scale(by: scaleDown, duration: duration)
        let scaleUpp = SKAction.scale(by: scaleUp, duration: duration)
        let seq = SKAction.sequence([scaleDwn, scaleUpp])
        let repeatSeq = SKAction.repeat(seq, count: 1)
        run(repeatSeq)
    }
}
