

import SpriteKit
import UIKit


class TargetObject: Sprite {
    
    var reward = 0
    
    init(imageName: String, reward: Int, mass: CGFloat, restitution: CGFloat) {
        super.init(named: imageName, x: 0, y: 0, z: 2)
        self.reward = reward
        self.size = CGSize(width: 120, height: 120)
        self.physicsBody = SKPhysicsBody(circleOfRadius: 60, center: CGPoint(x: 60, y: 60))
        self.physicsBody?.isDynamic = true
        self.physicsBody?.mass = mass
        self.physicsBody?.restitution = restitution
        //self.physicsBody?.angularDamping = 0.1
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
