import Foundation

enum BattleBackground {
    case standard
    
    var imageString: String {
        switch self {
        case .standard:
            "battleBackground"
        }
    }
}
