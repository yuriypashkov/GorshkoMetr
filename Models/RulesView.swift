

import SpriteKit
import UIKit

class RulesView {
    
    var node: SKNode
    var checkbox: Sprite!
    
    init(size: CGSize) {
        node = SKNode()
        node.zPosition = 5
        node.position = CGPoint(x: 0, y: 0)
        // спрайт с окошком
        let testSprite = Sprite(named: "rulesViewNew_6", x: size.width / 2, y: size.height / 2, z: 12)
        testSprite.setScale(1.6)
        testSprite.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        node.addChild(testSprite)
        // бекграунд
        let background = SKShapeNode(rect: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        background.fillColor = .white
        background.alpha = 0.8
        background.zPosition = 11
        node.addChild(background)
        // кнопка Закрыть
        let closeButton = Sprite(named: "closeNew", x: 2120, y: 1000, z: 13)
        closeButton.setScale(0.6)
        closeButton.anchorPoint = CGPoint(x: 0.5, y: 0)
        closeButton.name = "gameCloseRules"
        node.addChild(closeButton)
        // галочка При старте
        checkbox = Sprite(named: "check", x: 740, y: 87, z: 13)
        checkbox.setScale(1.2)
        //checkbox.name = "gameCheckbox"
        node.addChild(checkbox)
        // поле для нажатия поверх галки
        let nodeForTap = SKShapeNode(circleOfRadius: 50)
        nodeForTap.position = CGPoint(x: 765, y: 115)
        nodeForTap.fillColor = .clear
        nodeForTap.strokeColor = .clear
        nodeForTap.name = "gameCheckbox"
        nodeForTap.zPosition = 14
        node.addChild(nodeForTap)
    }
    
    func addTo(parent: SKScene) {
        parent.addChild(node)
    }
    
    func removeThis() {
        node.removeFromParent()
    }
    
}
