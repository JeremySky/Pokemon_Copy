import Foundation

enum PokemonMove {
    case tackle, fireball
    
    var name: String {
        switch self {
        case .tackle:       "tackle"
        case .fireball:     "fireball"
        }
    }
    
    var damageRange: ClosedRange<Int> {
        switch self {
        case .tackle:       2...5
        case .fireball:     4...8
        }
    }
    
    var sprite: Sprite? {
        switch self {
        case .fireball:     .fireball
        default:            nil
        }
    }
}
