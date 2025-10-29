import SwiftUI
import SpriteKit

struct MainView: View {
    
    @State var isInBattle: Bool = false
    
    var body: some View {
        ZStack {
            
            ExploreView(viewModel: ExploreViewModel(map: .pelletTown, triggerBattle: { isInBattle = true }))
            
            if isInBattle {
                BattleView(viewModel: BattleViewModel(playerPokemon: Emby(), enemyPokemon: Draggle(), endBattle: { isInBattle = false }))
                    .transition(.slide)
            }
            
        }
        .animation(.spring(duration: 0.42), value: isInBattle)
    }
}

#Preview {
    MainView()
}
