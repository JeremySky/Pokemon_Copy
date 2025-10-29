import SpriteKit

class ExploreScene: SKScene {
    // Scene's Children
    private let playerNode: PlayerNode
    private let backgroundNode: BackgroundNode
    private let foregroundNode: ForegroundNode
    
    // Player Movement
    var isMoving: Bool = false
    var playerDirection: PlayerDirection = .down
    private let movementSpeed: CGFloat = 3.0
    
    // Battle Zone
    private var battleZoneCounter: Int = 0
    private var isInBattleZone: Bool {  self.battleZoneCounter > 0 }
    var triggerBattle: () -> Void
    
    // Custom initializer
    init(map: Map, triggerBattle: @escaping () -> Void) {
        self.backgroundNode = BackgroundNode(map: map)
        self.playerNode = PlayerNode(texture: PlayerFrames.getIdleTexture(for: .down))
        self.foregroundNode = ForegroundNode(map: map)
        self.triggerBattle = triggerBattle
        
        // Super Init
        super.init(size: CGSize(width: 1024, height: 756))
        
        // Set up Scene Size
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.scaleMode = .aspectFill
        
        // Add Children
        addChild(self.backgroundNode)
        addChild(self.playerNode)
        addChild(self.foregroundNode)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func update(_ currentTime: TimeInterval) {
        guard isMoving else { return }
        if playerNode.canMove(playerDirection) { moveBackground() }
        if isInBattleZone { randomizeEncounter() }
    }
    
    func runActionLoop() {
        // Prepare loop
        let walkFrames: [SKTexture] = PlayerFrames.getMovingTextures(for: self.playerDirection)
        let walk = SKAction.animate(with: walkFrames, timePerFrame: 0.15)
        let loop = SKAction.repeatForever(walk)
        
        // Run loop
        if let textureNode = playerNode.childNode(withName: NodeName.playerTexture.value) as? SKSpriteNode {
            textureNode.run(loop)
        }
    }
    
    func setIdleTexture() {
        if let textureNode = playerNode.childNode(withName: NodeName.playerTexture.value) as? SKSpriteNode {
            textureNode.removeAllActions()
            textureNode.texture = PlayerFrames.getIdleTexture(for: self.playerDirection)
        }
    }
    
    private func moveBackground() {
        switch playerDirection {
        case .up:
            backgroundNode.position.y += -movementSpeed
            foregroundNode.position.y += -movementSpeed
        case .down:
            backgroundNode.position.y += movementSpeed
            foregroundNode.position.y += movementSpeed
        case .left:
            backgroundNode.position.x += movementSpeed
            foregroundNode.position.x += movementSpeed
        case .right:
            backgroundNode.position.x += -movementSpeed
            foregroundNode.position.x += -movementSpeed
        }
    }
    
    private func randomizeEncounter() {
        if Int.random(in: 0..<300) == 1 {
            self.isMoving = false
            setIdleTexture()
            
            triggerBattle()
        }
    }
}

extension ExploreScene: SKPhysicsContactDelegate {
    override func didMove(to view: SKView) {
        physicsWorld.gravity = .zero
        physicsWorld.contactDelegate = self
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        guard
            let nodeA = contact.bodyA.node,
            let nodeB = contact.bodyB.node,
            let nodeAName = nodeA.name,
            let nodeBName = nodeB.name
        else { return }
        
        // Determine which edge hit the boundary
        if nodeAName.contains(NodeName.edgeNameMarker) || nodeBName.contains(NodeName.edgeNameMarker) {
            let edgeName = nodeAName.contains(NodeName.edgeNameMarker) ? nodeAName : nodeBName
            let rawValue = edgeName.replacingOccurrences(of: "_\(NodeName.edgeNameMarker)", with: "")
            if let direction = PlayerDirection(rawValue: rawValue) {
                playerNode.isColliding(direction)
            }
        }
        
        // Catch if player's battle zone interact with map's battle zone
        if nodeAName.contains(NodeName.playerBattleZone.value) || nodeBName.contains(NodeName.playerBattleZone.value) {
            self.battleZoneCounter += 1
        }
    }
    func didEnd(_ contact: SKPhysicsContact) {
        guard let nodeAName = contact.bodyA.node?.name,
              let nodeBName = contact.bodyB.node?.name else { return }
        
        if nodeAName.contains(NodeName.edgeNameMarker) || nodeBName.contains(NodeName.edgeNameMarker) {
            let edgeName = nodeAName.contains(NodeName.edgeNameMarker) ? nodeAName : nodeBName
            let rawValue = edgeName.replacingOccurrences(of: "_\(NodeName.edgeNameMarker)", with: "")
            if let direction = PlayerDirection(rawValue: rawValue) {
                playerNode.stopColliding(direction)
            }
        }
        
        // Catch if player's battle zone interact with map's battle zone
        if nodeAName.contains(NodeName.playerBattleZone.value) || nodeBName.contains(NodeName.playerBattleZone.value) {
            self.battleZoneCounter -= 1
        }
    }
}
