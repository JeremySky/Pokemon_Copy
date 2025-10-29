import Foundation
import SpriteKit

class AnimatableSpriteNode: SKSpriteNode {
    private let idle: SKTexture
    private let action: SKAction
    
    init(sprite: Sprite) {
        let animationHandler = AnimationHandler(sprite: sprite)
        let texture = animationHandler.idle
        self.idle = animationHandler.idle
        self.action = animationHandler.action
        super.init(texture: texture, color: .clear, size: texture.size())
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func animate() {
        self.run(action)
    }
    
    func stopAnimation() {
        self.removeAllActions()
        self.texture = idle
    }
}
