import SpriteKit

struct PlayerFrames {
    
    // MARK: - Getter Functions
    static func getIdleTexture(for direction: PlayerDirection) -> SKTexture {
        guard let texture = idle[direction] else { fatalError("No idle texture for \(direction)") }
        return texture
    }
    
    static func getMovingTextures(for direction: PlayerDirection) -> [SKTexture] {
        guard let textures = moving[direction] else { fatalError("No moving texture for \(direction)") }
        return textures
    }
    
    // MARK: - Compute Textures
    static private var moving: [PlayerDirection:[SKTexture]] {
        var frames: [PlayerDirection:[SKTexture]] = [:]
        
        for sheet in PlayerDirection.allCases {
            let texture = SKTexture(imageNamed: sheet.assetName)
            
            let frameCount = 4
            let frameWidth = texture.size().width / CGFloat(frameCount)
            
            // Slice frames horizontally
            for i in 0..<frameCount {
                let rect = CGRect(
                    x: CGFloat(i) * frameWidth / texture.size().width,
                    y: 0,
                    width: frameWidth / texture.size().width,
                    height: 1.0
                )
                let frameTexture = SKTexture(rect: rect, in: texture)
                frames[sheet, default: []].append(frameTexture)
            }
        }
        
        return frames
    }

    static private var idle: [PlayerDirection:SKTexture] {
        var frames: [PlayerDirection:SKTexture] = [:]
        
        for (direction, movingFrames) in PlayerFrames.moving {
            guard let firstFrame = movingFrames.first else { fatalError("\(#file):\(#function) - playerFrames[.down].first is nil") }
            guard let rightIdleFrame = movingFrames.last else { fatalError("\(#file):\(#function) - playerFrames[.right].last is nil") }
            frames[direction] = (direction == .right ? rightIdleFrame : firstFrame) // Player Direction Right's idle frame is the last frame
        }
        
        return frames
    }
}
