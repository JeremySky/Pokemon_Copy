import Foundation
import SpriteKit

class AnimationHandler {
    let idle: SKTexture
    let action: SKAction
    
    init(sprite: Sprite) {
        let frameCount = sprite.frameCount
        let panel = SKTexture(imageNamed: sprite.imageString)
        let widthRatio: CGFloat = 1.0 / CGFloat(frameCount)
        let frames: [SKTexture] = getFrames()
        let animation = SKAction.animate(with: frames, timePerFrame: sprite.timePerFrame)
        let action = SKAction.repeatForever(animation)
        guard let idleFrame = frames.first else { fatalError("No idle frame found") }
        
        self.idle = idleFrame
        self.action = action
        

        // MARK: - Nested Function
        func getFrames() -> [SKTexture] {
            var frames: [SKTexture] = []
            
            for i in 0..<frameCount {
                
                let rect = CGRect(
                    x: CGFloat(i) * widthRatio,
                    y: 0,
                    width: widthRatio,
                    height: 1
                )
                
                let frame = SKTexture(rect: rect, in: panel)
                
                frames.append(frame)
            }
            
            return frames
        }
    }
}
