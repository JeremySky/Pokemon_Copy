import Foundation

protocol Pokemon {
    var id: UUID { get }
    var name: String { get set }
    var maxHP: Int { get set }
    var currentHP: Int { get set }
    var moves: MovesSet { get set }
    var sprite: Sprite { get }
}

struct MovesSet {
    var move1: PokemonMove
    var move2: PokemonMove?
    var move3: PokemonMove?
    var move4: PokemonMove?
    
    func getAll() -> [PokemonMove] {
        let moves: [PokemonMove?] = [move1, move2, move3, move4]
        return moves.compactMap{$0}
    }
}

@Observable
class Emby: Pokemon {
    let id: UUID = UUID()
    var name: String = "Emby"
    var maxHP: Int = 30
    var currentHP: Int = 30
    var moves: MovesSet = MovesSet(move1: .tackle, move2: .fireball)
    let sprite: Sprite = .emby
}

@Observable
class Draggle: Pokemon {
    var id: UUID = UUID()
    var name: String = "Draggle"
    var maxHP: Int = 20
    var currentHP: Int = 20
    var moves: MovesSet = MovesSet(move1: .tackle)
    var sprite: Sprite = .draggle
}
