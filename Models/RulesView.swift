

import SpriteKit
import UIKit

class RulesView {
    
    var node: SKNode
    
    init(size: CGSize) {
        node = SKNode()
        node.zPosition = 5
        node.position = CGPoint(x: 0, y: 0)
        // спрайт с окошком
        let testSprite = Sprite(named: "rulesWindow", x: size.width / 2, y: size.height / 2, z: 5)
        testSprite.setScale(1.2)
        testSprite.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        node.addChild(testSprite)
        // бекграунд
        let background = SKShapeNode(rect: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        background.fillColor = .white
        background.alpha = 0.8
        background.zPosition = 4
        node.addChild(background)
        // кнопка Закрыть
        let closeButton = Sprite(named: "closeButtonMenu", x: size.width / 2, y: 100, z: 6)
        closeButton.anchorPoint = CGPoint(x: 0.5, y: 0)
        closeButton.name = "gameCloseRules"
        node.addChild(closeButton)
    }
    
    func addTo(parent: SKScene) {
        parent.addChild(node)
    }
    
    func removeThis() {
        node.removeFromParent()
    }
    
}
