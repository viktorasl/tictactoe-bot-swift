//
//  base.swift
//  tictactoe-swift
//
//  Created by Viktoras Laukevičius on 13/12/15.
//
//

import Foundation

public enum Player: String {
    case X = "x"
    case O = "o"
    
    init?(key: String) {
        switch key {
            case "x": self = .X
            case "o": self = .O
            default: return nil
        }
    }
    
    var urlKey: Int {
        switch self {
        case .X: return 1
        case .O: return 2
        }
    }
}

public struct BoardField {
    let x: UInt
    let y: UInt
    let player: Player
}

public struct Board {
    let fields: [BoardField]
}
