import SwiftUI

struct BattleUI: View {
    
    @Binding var viewModel: BattleViewModel
    
    var body: some View {
        VStack {
            StatusBar(isPlayer: false, pokemon: $viewModel.enemyPokemon)
                .frame(width: 450)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                .padding(.top, 20)
                .padding(.leading, 70)
            
            HStack(alignment: .bottom) {
                StatusBar(isPlayer: true, pokemon: $viewModel.playerPokemon)
                
                MovesSelection(viewModel: $viewModel)
                    .disabled(viewModel.disableUI)
                    .opacity(viewModel.disableUI ? 0.5 : 1)
            }
            .frame(maxHeight: .infinity, alignment: .bottom)
            .padding(25)
        }
    }
}


#Preview {
    @Previewable @State var viewModel = BattleViewModel(playerPokemon: Emby(), enemyPokemon: Draggle()) {}
    BattleUI(viewModel: $viewModel)
}
