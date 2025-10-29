import SpriteKit

class ForegroundNode: SKSpriteNode {
    init(map: Map) {
        let texture = SKTexture(imageNamed: map.foregroundAssetString)
        super.init(texture: texture, color: .clear, size: texture.size())
        self.position = map.foregroundStartingPosition
        self.zPosition = 1
        self.anchorPoint = .zero
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
