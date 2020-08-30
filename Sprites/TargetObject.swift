

import SpriteKit
import UIKit


class TargetObject: Sprite {
    
    var reward: Int!
    var isGoodItem: Bool!
    var isBayan = false
    var isLightning = false
    
    init(imageName: String, reward: Int, mass: CGFloat, restitution: CGFloat, isGoodItem: Bool, isBayan: Bool = false, isLightning: Bool = false) {
        super.init(named: imageName, x: 0, y: 0, z: 2)
        self.isGoodItem = isGoodItem
        self.reward = reward
        self.isBayan = isBayan
        self.isLightning = isLightning
        self.size = CGSize(width: 120, height: 120)
        self.physicsBody = SKPhysicsBody(circleOfRadius: 60, center: CGPoint(x: 60, y: 60))
        self.physicsBody?.isDynamic = true
        self.physicsBody?.mass = mass
        self.physicsBody?.restitution = restitution
        //self.physicsBody?.allowsRotation = false
        self.name = "target"
        //self.physicsBody?.angularDamping = 0.1
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
