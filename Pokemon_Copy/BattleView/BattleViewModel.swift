import Foundation

@MainActor @Observable
final class BattleViewModel {
    
    let scene: BattleScene
    var playerPokemon: Pokemon
    var enemyPokemon: Pokemon
    var isPlayersTurn: Bool
    var disableUI: Bool
    var isAnimating: Bool
    var endBattle: () -> Void
    
    init(playerPokemon: Pokemon, enemyPokemon: Pokemon, endBattle: @escaping () -> Void) {
        let isPlayerFirst = true
        
        self.scene = BattleScene(player: playerPokemon, enemy: enemyPokemon)
        self.playerPokemon = playerPokemon
        self.enemyPokemon = enemyPokemon
        self.isPlayersTurn = isPlayerFirst
        self.disableUI = !isPlayerFirst
        self.isAnimating = false
        self.endBattle = endBattle
    }
    
    func handleAnimationDone() {
        if playerPokemon.currentHP <= 0 || enemyPokemon.currentHP <= 0 { endBattle() }
        isAnimating = false
    }
    
    func handleEnemyTurn() {
        Task {
            try! await Task.sleep(nanoseconds: 800_000_000)
            guard let randomMove = self.enemyPokemon.moves.getAll().randomElement() else { fatalError("\(#file) \(#function) - unable to get enemy pokemon's random move")}
            self.isAnimating = true
            handle(randomMove, isPlayer: false)
            
            let damage = randomizeDamage(randomMove)
            deal(damage, to: &playerPokemon)
        }
    }
    
    func handleSelected(_ move: PokemonMove, isPlayer: Bool) {
        self.isAnimating = true
        handle(move, isPlayer: true)
        
        let damage = randomizeDamage(move)
        deal(damage, to: &enemyPokemon)
        
        self.disableUI = true
    }
    
    func handle(_ move: PokemonMove, isPlayer: Bool) {
        switch move {
        case .tackle:
            scene.tackle(isPlayer: isPlayer)
        case .fireball:
            scene.fireball(isPlayer: isPlayer)
        }
    }
    
    // MARK: - Helper Functions
    private func randomizeEnemySelection() {
        guard let randomMove = enemyPokemon.moves.getAll().randomElement() else { fatalError("\(#file) \(#function) - unable to get random move") }
        let damage = randomizeDamage(randomMove)
        deal(damage, to: &playerPokemon)
    }
    
    private func randomizeDamage(_ move: PokemonMove) -> Int {
        guard let damage = move.damageRange.randomElement() else { fatalError("\(#file) \(#function) - unable to get random damage") }
        return damage
    }
    
    private func deal(_ damage: Int,to pokemon: inout Pokemon) {
        pokemon.currentHP = max(0, pokemon.currentHP - damage)
    }
}

extension BattleViewModel {
    static var mock = BattleViewModel(playerPokemon: Emby(), enemyPokemon: Draggle()) {}
}
