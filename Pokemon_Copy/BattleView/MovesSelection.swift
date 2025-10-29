import SwiftUI

struct MovesSelection: View {
    
    @Binding var viewModel: BattleViewModel
    
    var body: some View {
        VStack {
            ForEach(viewModel.playerPokemon.moves.getAll(), id: \.self) { move in
                
                Button { viewModel.handleSelected(move, isPlayer: true) } label: {
                    Text(move.name.uppercased())
                        .foregroundStyle(.black)
                        .font(.title)
                        .fontWeight(.bold)
                        .kerning(0.2)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .fill(Color.white)
                        )
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.black, lineWidth: 4)
                        )
                }
                .frame(height: 45)
                
                
            }
        }
        .frame(width: 260)
        .opacity(0.9)
    }
}

#Preview {
    @Previewable @State var viewModel: BattleViewModel = .mock
    MovesSelection(viewModel: $viewModel)
}
