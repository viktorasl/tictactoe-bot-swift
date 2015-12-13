//
//  encode.swift
//  tictactoe-swift
//
//  Created by Viktoras Laukevičius on 13/12/15.
//
//

import Foundation

private func encodeField(field: BoardField) -> String {
    return "d1:v1:\(field.player.rawValue)1:xi\(field.x)e1:yi\(field.y)ee"
}

private func encodeFieldDict(idx: Int, field: BoardField) -> String {
    let idxTxt = "\(idx)"
    return "\(idxTxt.characters.count):\(idxTxt)\(encodeField(field))"
}

func encodeBencodeList(board: Board) -> String {
    return "l" + board.map{ encodeField($0) }.joinWithSeparator("") + "e"
}

func encodeBencodeDict(board: Board) -> String {
    return "d" + board.enumerate().map{ encodeFieldDict($0, field: $1) }.joinWithSeparator("") + "e"
}
