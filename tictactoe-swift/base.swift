//
//  base.swift
//  tictactoe-swift
//
//  Created by Viktoras Laukevičius on 13/12/15.
//
//

enum Player: String {
    case X = "x"
    case O = "o"
    
    init?(char: Character) {
        self = .X
    }
}

struct BoardField {
    let x: Int
    let y: Int
    let player: Player
}

typealias Board = [BoardField]
