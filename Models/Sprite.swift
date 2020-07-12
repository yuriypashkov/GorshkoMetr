//
//  Sprite.swift
//  GorshkoMetr
//
//  Created by Yuriy Pashkov on 6/20/20.
//  Copyright © 2020 Yuriy Pashkov. All rights reserved.
//

import SpriteKit

class Sprite: SKSpriteNode {
    init(named: String, x: CGFloat, y: CGFloat, z: CGFloat) {
        let texture = SKTexture(imageNamed: named)
        super.init(texture: texture, color: UIColor.clear, size: texture.size())
        self.position = CGPoint(x: x, y: y)
        self.anchorPoint = CGPoint(x: 0, y: 0)
        self.zPosition = z
        self.name = named
    }
    
    convenience init(named: String, x: CGFloat, y: CGFloat, z: CGFloat, size: CGSize) {
        self.init(named: named, x: x, y: y, z: z)
        self.size = size
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
