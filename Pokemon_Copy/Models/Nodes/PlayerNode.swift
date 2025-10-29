import SpriteKit

class PlayerNode: SKSpriteNode {
    private var collidingWith: [PlayerDirection:Int] = [.left : 0, .right : 0, .up : 0, .down : 0]
    
    init(texture: SKTexture) {
        let length: CGFloat = texture.size().width
        let collisionSize = CGSize(width: length, height: length)
        
        super.init(texture: nil, color: .clear, size: collisionSize)
        
        // Set Texture Child Node
        let textureNode = SKSpriteNode(texture: texture)
        textureNode.name = NodeName.playerTexture.value
        textureNode.anchorPoint = CGPoint(x: 0.5, y: 0.3)
        self.addChild(textureNode)
        
        // Set Edge Nodes
        addEdgeNodes()
        
        // Set Battle Zone Node
        addBattleZoneNode()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addBattleZoneNode() {
        let length = self.size.width * 0.6
        let size = CGSize(width: length, height: length)
        let physicsCategory = PhysicsCategory.playerBattleZone
        
        let battleZoneNode = SKSpriteNode(color: .clear, size: size)
        battleZoneNode.name = physicsCategory.name.value
        
        // Set Physics Body
        let physicsBody = SKPhysicsBody(rectangleOf: size)
        physicsBody.isDynamic = true
        physicsBody.allowsRotation = false
        physicsBody.pinned = true
        physicsBody.categoryBitMask = physicsCategory.rawValue
        physicsBody.contactTestBitMask = PhysicsCategory.battleZone.rawValue
        battleZoneNode.physicsBody = physicsBody
        
        self.addChild(battleZoneNode)
    }
    
    private func addEdgeNodes() {
        let length = self.size.width - edgeWidth
        
        for direction in PlayerDirection.allCases {
            let physicsCategory = PhysicsCategory.playerEdge(direction)
            
            let edgeNode = SKSpriteNode(color: .clear, size: edgeSize(for: direction, length: length))
            edgeNode.name = physicsCategory.name.value
            
            // Position at the edge
            edgeNode.position = edgePosition(for: direction, length: self.size.width)
            
            // Physics body
            let physicsBody = SKPhysicsBody(rectangleOf: edgeNode.size)
            physicsBody.isDynamic = true       // must be dynamic to detect contact
            physicsBody.affectedByGravity = false
            physicsBody.allowsRotation = false
            physicsBody.pinned = true          // lock to parent
            physicsBody.categoryBitMask = physicsCategory.rawValue
            physicsBody.collisionBitMask = 0   // don’t push anything
            physicsBody.contactTestBitMask = PhysicsCategory.boundary.rawValue
            edgeNode.physicsBody = physicsBody
            
            self.addChild(edgeNode)
        }
    }
    
    private let edgeWidth: CGFloat = 3
    
    // Edge sizes: thin in the orthogonal direction
    private func edgeSize(for direction: PlayerDirection, length: CGFloat) -> CGSize {
        switch direction {
        case .up, .down:
            return CGSize(width: length, height: edgeWidth) // thin horizontal edge
        case .left, .right:
            return CGSize(width: edgeWidth, height: length) // thin vertical edge
        }
    }
    
    // Edge positions relative to player
    private func edgePosition(for direction: PlayerDirection, length: CGFloat) -> CGPoint {
        switch direction {
        case .up: return CGPoint(x: 0, y: length/2)
        case .down: return CGPoint(x: 0, y: -length/2)
        case .left: return CGPoint(x: -length/2, y: 0)
        case .right: return CGPoint(x: length/2, y: 0)
        }
    }
    
    func canMove(_ direction: PlayerDirection) -> Bool {
        guard let collisionCount: Int = self.collidingWith[direction] else { fatalError("\(#file) \(#function) - Invalid direction: \(direction)") }
        let canMove = (collisionCount == 0)
        
        return canMove
    }
    
    func isColliding(_ direction: PlayerDirection) {
        self.collidingWith[direction, default: 0] += 1
        
        let keys = Array(self.collidingWith.keys)
        for key in keys {
            print("\(key.rawValue.capitalized) : \(self.collidingWith[key]!)")
        }
        print()
    }
    
    func stopColliding(_ direction: PlayerDirection) {
        self.collidingWith[direction, default: 1] -= 1
        
        print("Stop: \(direction.rawValue.capitalized)\n")
    }
}
