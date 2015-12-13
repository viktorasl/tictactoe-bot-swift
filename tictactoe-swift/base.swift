//
//  base.swift
//  tictactoe-swift
//
//  Created by Viktoras Laukevičius on 13/12/15.
//
//

import Foundation

enum Player: String {
    case X = "x"
    case O = "o"
    
    var urlKey: Int {
        switch self {
        case .X: return 1
        case .O: return 2
        }
    }
}

struct BoardField {
    let x: Int
    let y: Int
    let player: Player
}

typealias Board = [BoardField]
