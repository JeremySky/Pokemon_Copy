import Foundation
import SpriteKit

class PokemonNode: AnimatableSpriteNode {
    let startingXPosition: CGFloat
    var isInStartingPosition: Bool { self.position.x == self.startingXPosition }
    
    init(_ pokemon: Pokemon, isPlayer: Bool) {
        self.startingXPosition = isPlayer ? PokemonNode.playerPosition.x : PokemonNode.enemyPosition.x
        
        super.init(sprite: pokemon.sprite)
        self.position = isPlayer ? PokemonNode.playerPosition : PokemonNode.enemyPosition
        self.setScale(isPlayer ? 2.8 : 0.8)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    static let playerPosition: CGPoint = .init(x: -160, y: -30)
    static let enemyPosition: CGPoint = .init(x: 330, y: 125)
}
