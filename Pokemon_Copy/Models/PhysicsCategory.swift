//
//  PhysicsCategory.swift
//  Pokemon_Copy
//
//  Created by Jeremy Manlangit on 10/20/25.
//

import Foundation

enum PhysicsCategory {
    case none
    case playerBody
    case playerEdge(PlayerDirection)
    case boundary
    case battleZone
    case playerBattleZone
    
    var rawValue: UInt32 {
        switch self {
        case .none:
            return 0
        case .playerBody:
            return 0b1
        case .playerEdge(_):
            return 0b10
        case .boundary:
            return 0b100
        case .battleZone:
            return 0b1000
        case .playerBattleZone:
            return 0b10000
        }
    }
    
    var name: NodeName {
        switch self {
        case .none: return .none
        case .playerBody: return .playerBody
        case .playerEdge(let direction): return .playerEdge(direction)
        case .boundary: return .boundary
        case .battleZone: return .battleZone
        case .playerBattleZone: return .playerBattleZone
        }
    }
}

enum NodeName {
    case none, playerBody, playerEdge(PlayerDirection), boundary, battleZone, playerTexture, playerBattleZone
    
    var value: String {
        switch self {
        case .none:
            "none"
        case .playerBody:
            "player_body"
        case .playerEdge(let direction):
            "\(direction.rawValue)_\(NodeName.edgeNameMarker)"
        case .boundary:
            "boundary"
        case .battleZone:
            "battle_zone"
        case .playerTexture:
            "player_texture"
        case .playerBattleZone:
            "player_battle_zone"
        }
    }
    
    static var edgeNameMarker: String = "edge"
}
