//
//  Block.swift
//  GorshkoMetr
//
//  Created by Yuriy Pashkov on 6/25/20.
//  Copyright © 2020 Yuriy Pashkov. All rights reserved.
//

import SpriteKit

class Block: SKShapeNode {
    
    init(position: CGPoint, rotation: CGFloat) {
        super.init()
        let block = SKShapeNode(rect: CGRect(x: -200, y: -25, width: 400, height: 50))
        block.zPosition = 2
        block.fillColor = .gray
        block.position = position
        block.zRotation = rotation
        block.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 400, height: 50))
        block.physicsBody?.isDynamic = false
        addChild(block)
    }
    
    func addTo(parent: SKNode) {
        parent.addChild(self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

