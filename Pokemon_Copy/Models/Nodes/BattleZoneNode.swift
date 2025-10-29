import SpriteKit

class BattleZoneNode: SKSpriteNode {
    init(position: CGPoint, size: CGSize) {
        let physicsCategory = PhysicsCategory.battleZone
        super.init(texture: nil, color: .clear, size: size)
        self.name = physicsCategory.name.value
        self.alpha = 0.4
        self.position = position
        
        let physicsBody = SKPhysicsBody(rectangleOf: size)
        physicsBody.isDynamic = false
        physicsBody.categoryBitMask = physicsCategory.rawValue
        
        self.physicsBody = physicsBody
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

