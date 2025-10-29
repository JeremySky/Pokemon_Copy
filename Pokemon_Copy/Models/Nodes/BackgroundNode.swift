import SpriteKit

class BackgroundNode: SKSpriteNode {
    init(map: Map) {
        let texture = SKTexture(imageNamed: map.assetString)
        super.init(texture: texture, color: .clear, size: texture.size())
        self.position = map.startingPosition
        self.zPosition = -1
        self.anchorPoint = .zero
        
        
        // Add Boundary Nodes
        for (y, row) in map.collisionsMap.enumerated() {
            for (x, column) in row.enumerated() {
                guard column == map.collisionMarker else { continue }
                
                // Boundary Node Size
                let width = self.size.width / map.tileMapSize.width 
                let height = self.size.height / map.tileMapSize.height
                let size = CGSize(width: width, height: height)
                
                // Boundary Node Position
                let boundaryPositionX = (x * Int(width)) + Int(width / 2)
                let boundaryPositionY = (y * Int(height)) + Int(height / 2)
                let position = CGPoint(x: boundaryPositionX, y: boundaryPositionY)
                
                let boundaryNode = BoundaryNode(position: position, size: size)
                
                self.addChild(boundaryNode)
            }
        }
        
        
        // Add Battle Zone Nodes
        for (y, row) in map.battleZoneMap.enumerated() {
            for (x, column) in row.enumerated() {
                guard column == map.battleZoneMarker else { continue }
                
                // Boundary Node Size
                let width = map.size.width / map.tileMapSize.width
                let height = map.size.height / map.tileMapSize.height
                let size = CGSize(width: width, height: height)
                
                // Boundary Node Position
                let battleZonePositionX = (x * Int(width)) + Int(width / 2)
                let battleZonePositionY = (y * Int(height)) + Int(height / 2)
                let position = CGPoint(x: battleZonePositionX, y: battleZonePositionY)
                
                let battleZoneNode = BattleZoneNode(position: position, size: size)
                battleZoneNode.zPosition = 1
                
                self.addChild(battleZoneNode)
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

