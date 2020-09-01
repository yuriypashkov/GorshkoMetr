

import SpriteKit
import UIKit


class TargetObject: Sprite {
    
    var reward: Int!
    var isGoodItem: Bool!
    var type: TargetType!
    
    init(imageName: String, reward: Int, mass: CGFloat, restitution: CGFloat, isGoodItem: Bool, type: TargetType) {
        super.init(named: imageName, x: 0, y: 0, z: 2)
        self.isGoodItem = isGoodItem
        self.reward = reward
        //self.size = CGSize(width: 120, height: 120)
        self.physicsBody = SKPhysicsBody(circleOfRadius: 60, center: CGPoint(x: 60, y: 60))
        self.physicsBody?.isDynamic = true
        self.physicsBody?.mass = mass
        self.physicsBody?.restitution = restitution
        self.type = type
        if type == .beer {
            self.physicsBody?.allowsRotation = false
        }
        //self.physicsBody?.allowsRotation = false
        self.name = "target"
        //self.physicsBody?.angularDamping = 0.1
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

enum TargetType: CaseIterable {
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
