import Foundation

@MainActor @Observable
class ExploreViewModel {
    let scene: ExploreScene
    
    init(map: Map, triggerBattle: @escaping () -> Void) {
        self.scene = ExploreScene(map: map, triggerBattle: triggerBattle)
    }
    
    func handleMovement(direction: PlayerDirection) {
        guard scene.playerDirection != direction || !scene.isMoving else { return }
        scene.playerDirection = direction
        scene.runActionLoop()
        scene.isMoving = true
    }
    
    func stopMovement() {
        scene.isMoving = false
        scene.setIdleTexture()
    }
}

extension ExploreViewModel {
    static var mock = ExploreViewModel(map: .pelletTown) {}
}
