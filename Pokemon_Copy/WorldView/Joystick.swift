import SwiftUI

struct Joystick: View {
    @Binding var viewModel: ExploreViewModel
    
    @State var offsetX: CGFloat = 0
    @State var offsetY: CGFloat = 0
    @State var scale: CGFloat = 1
    
    private let joystickDiameter: CGFloat = 60
    private let maxRadius: CGFloat = 10
    private let scaledDown: CGFloat = 0.98
    private let resetAnimationDuration: TimeInterval = 0.19
    private let extraBounce: Double = 0.46
    
    var body: some View {
        ZStack {
            Circle()
                .stroke().foregroundStyle(.black.opacity(0.5))
                .frame(width: joystickDiameter + maxRadius, height: joystickDiameter + maxRadius)
            
            Circle()
                .background(Circle().foregroundStyle(.white.opacity(0.5)))
                .frame(width: joystickDiameter, height: joystickDiameter)
                .foregroundStyle(RadialGradient(colors: [.black.opacity(0.7), .black.opacity(0.7), .black.opacity(0.63)], center: .center, startRadius: 0, endRadius: joystickDiameter / 2))
                .offset(x: offsetX, y: offsetY)
                .scaleEffect(scale)
                .gesture(drag)
        }
    }
    
    private var drag: some Gesture {
        DragGesture()
            .onChanged { value in
                withAnimation { self.scale = scaledDown }
                
                // Capture translations
                var width = value.translation.width
                var height = value.translation.height
                
                // Calculate PlayerDirection
                let direction = calculatePlayerDirection(width, height)
                
                // Set player moving status
                if width == 0 && height == 0 {
                    //TODO: Stop movement
                    viewModel.stopMovement()
                } else {
                    //TODO: Move
                    viewModel.handleMovement(direction: direction)
                }
                
                // Limits joystick's offset distance to maxRadius
                let distance = sqrt(width * width + height * height)
                if distance > maxRadius {
                    let scale = maxRadius / distance
                    let scaledWidth = width * scale
                    let scaledHeight = height * scale
                    width = scaledWidth
                    height = scaledHeight
                }
                
                // Set offsets
                self.offsetX = width
                self.offsetY = height
            }
            .onEnded { _ in
                //TODO: Stop movement
                self.viewModel.stopMovement()
                withAnimation(.bouncy(duration: resetAnimationDuration, extraBounce: extraBounce)) {
                    self.offsetX = 0
                    self.offsetY = 0
                    self.scale = 1
                }
            }
    }
    
    private func calculatePlayerDirection(_ width: CGFloat, _ height: CGFloat) -> PlayerDirection {
        let absWidth = abs(width)
        let absHeight = abs(height)
        
        // Horizontal movement dominates
        if absWidth > absHeight {
            return width > 0 ? .right : .left
            
            // Vertical movement dominates
        } else {
            return height > 0 ? .down : .up
        }
    }
}

#Preview {
    @Previewable @State var viewModel: ExploreViewModel = .mock
    Joystick(viewModel: $viewModel)
}
