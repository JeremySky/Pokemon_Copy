import SwiftUI
import SpriteKit

struct BattleView: View {
    
    @State var viewModel: BattleViewModel
    
    var body: some View {
        ZStack {
            BattleSpriteView(viewModel: $viewModel)
            
            BattleUI(viewModel: $viewModel)
        }
        .ignoresSafeArea()
        .onAppear {
            viewModel.scene.moveAnimationCompletionHandler = viewModel.handleAnimationDone
            if viewModel.isPlayersTurn == false { viewModel.handleEnemyTurn() }
        }
        .onChange(of: viewModel.isAnimating) { oldValue, newValue in
            if viewModel.isAnimating == false {
                viewModel.isPlayersTurn.toggle()
            }
        }
        .onChange(of: viewModel.isPlayersTurn) { oldValue, newValue in
            if viewModel.isPlayersTurn == false {
                viewModel.handleEnemyTurn()
            } else {
                viewModel.disableUI.toggle()
            }
        }
    }
}

struct BattleSpriteView: View {
    
    @Binding var viewModel: BattleViewModel
    
    var body: some View {
        SpriteView(scene: viewModel.scene)
    }
}
#Preview {
    BattleView(viewModel: .mock)
}

