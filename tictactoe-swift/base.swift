//
//  base.swift
//  tictactoe-swift
//
//  Created by Viktoras Laukevičius on 13/12/15.
//
//

enum Player {
    case X
    case O
    
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
