import Foundation

enum PlayerDirection: String, CaseIterable {
    case down, left, right, up
    
    var assetName: String {
        switch self {
        case .down:
            "playerDown"
        case .left:
            "playerLeft"
        case .right:
            "playerRight"
        case .up:
            "playerUp"
        }
    }
}
