import SwiftUI
import SpriteKit

struct ExploreView: View {
    
    @State var viewModel: ExploreViewModel
    
    var body: some View {
        ZStack {
            GameSpriteView(viewModel: $viewModel)
            
            Joystick(viewModel: $viewModel)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomLeading)
                .padding(40)
        }
        .ignoresSafeArea()
    }
}

struct GameSpriteView: View {
    
    @Binding var viewModel: ExploreViewModel
    
    var body: some View {
        SpriteView(scene: viewModel.scene)
    }
}

#Preview {
    ExploreView(viewModel: .mock)
}
