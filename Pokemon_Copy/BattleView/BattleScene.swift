import Foundation
import SpriteKit

class FireballNode: AnimatableSpriteNode {
    let frames: CGFloat = 60
    
    let isFromPlayer: Bool
    
    let startingPosition: CGPoint
    let endingPosition: CGPoint
    var xTravelSpeed: CGFloat { (abs(startingPosition.x) + abs(endingPosition.x)) / frames }
    var yTravelSpeed: CGFloat { (abs(startingPosition.y) + abs(endingPosition.y)) / frames }
    
    let startingScale: CGFloat
    let endingScale: CGFloat
    var scale: CGFloat
    var scaleSpeed: CGFloat { (max(startingScale, endingScale) - min(startingScale, endingScale)) / frames }
    
    var isAtEndPosition: Bool {
        if startingPosition.x < endingPosition.x {
            return position.x >= endingPosition.x
        } else {
            return position.x <= endingPosition.x
        }
    }
    
    init(isFromPlayer: Bool) {
        self.isFromPlayer = isFromPlayer
        self.startingPosition = isFromPlayer ? PokemonNode.playerPosition : PokemonNode.enemyPosition
        self.endingPosition = isFromPlayer ? PokemonNode.enemyPosition : PokemonNode.playerPosition
        self.startingScale = isFromPlayer ? 2.8 : 0.8
        self.endingScale = isFromPlayer ? 0.8 : 2.8
        self.scale = startingScale
        super.init(sprite: Sprite.fireball)
        self.position = startingPosition
        self.setScale(scale)
        self.zRotation = isFromPlayer ? (-.pi / 3.8) : (.pi / 1.5)
        
        self.animate()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func travel() {
        guard !isAtEndPosition else { return }
        if isFromPlayer {
            self.position.x += xTravelSpeed
            self.position.y += yTravelSpeed
            scale -= scaleSpeed
        } else {
            self.position.x -= xTravelSpeed
            self.position.y -= yTravelSpeed
            scale += scaleSpeed
        }
        self.setScale(scale)
    }
}

class BattleScene: SKScene {
    let playerNode: PokemonNode
    let enemyNode: PokemonNode
    var fireballNode: FireballNode?
    
    var isTackling: Bool = false
    var isPlayerTackling: Bool = false
    var countRight: Int = 0
    var countLeft: Int = 0
    var count: Int = 0
    var tackleSpeed: CGFloat { isPlayerTackling ? 20 : 5}
    
    var moveAnimationCompletionHandler: (() -> Void)!
    
    init(player: Pokemon, enemy: Pokemon) {
        let playerNode = PokemonNode(player, isPlayer: true)
        let enemyNode = PokemonNode(enemy, isPlayer: false)
        
        self.playerNode = playerNode
        self.enemyNode = enemyNode
        self.fireballNode = nil
        
        super.init(size: CGSize(width: 1024, height: 756))
        self.scaleMode = .resizeFill
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        self.addChild(SKSpriteNode(imageNamed: BattleBackground.standard.imageString))
        self.addChild(enemyNode)
        self.addChild(playerNode)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func update(_ currentTime: TimeInterval) {
        if isTackling {
            let node = isPlayerTackling ? playerNode : enemyNode
            guard count != 0 else { countRight = 0; countLeft = 0; isTackling = false; return }
            if countRight > 0 {
                node.position.x += tackleSpeed
                countRight -= 1
                countLeft = countRight == 0 ? 5 : 0
            } else if countLeft > 0 {
                node.position.x -= tackleSpeed
                countLeft -= 1
                countRight = countLeft == 0 ? 5 : 0
            }
            count -= node.isInStartingPosition ? 1 : 0
        }
        
        if let fireballNode {
            fireballNode.travel()
            if fireballNode.isAtEndPosition {
                fireballNode.removeFromParent()
                self.fireballNode = nil
            }
        }
        
        if !isTackling && fireballNode == nil {
            moveAnimationCompletionHandler()
        }
    }
    
    override func didMove(to view: SKView) {
        playerNode.animate()
        enemyNode.animate()
    }
    
    func fireball(isPlayer: Bool) {
        self.fireballNode = FireballNode(isFromPlayer: isPlayer)
        addChild(fireballNode!)
    }
    
    func tackle(isPlayer: Bool) {
        count = 2
        isTackling = true
        isPlayerTackling = isPlayer
        countRight = isPlayer ? 5 : 0
        countLeft = isPlayer ? 0 : 5
    }
}
