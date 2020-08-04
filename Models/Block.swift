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
        let block = SKShapeNode(rect: CGRect(x: -425, y: -20, width: 850, height: 40))
        block.strokeColor = .clear
        block.zPosition = 2
        block.fillColor = .clear
        block.position = position
        block.zRotation = rotation
        block.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 850, height: 40))
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

