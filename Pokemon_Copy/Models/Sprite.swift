import Foundation

enum Sprite {
    case emby, draggle, fireball
    
    var imageString: String {
        switch self {
        case .emby:         "embySprite"
        case .draggle:      "draggleSprite"
        case .fireball:     "fireball"
        }
    }
    
    var frameCount: Int {
        switch self {
        default: 4
        }
    }
    
    var timePerFrame: CGFloat {
        switch self {
        case .emby:
            0.2
        case .draggle:
            0.25
        case .fireball:
            0.1
        }
    }
}
