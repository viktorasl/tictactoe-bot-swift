//
//  decode.swift
//  tictactoe-swift
//
//  Created by Viktoras Laukevičius on 13/12/15.
//
//

import FootlessParser

private func fieldify(player: Player)(x: Int)(y: Int) -> BoardField {
    return BoardField(x: x, y: y, player: player)
}

// Coordinates parsing
private let parseX = {Int("\($0)")!} <^> (tokens("1:xi") *> oneOf("012"))
private let parseY = {Int("\($0)")!} <^> (tokens("1:yi") *> oneOf("012"))

// Players parsing
private let parsePlayerX = {_ in Player.X} <^> oneOf("xX")
private let parsePlayerO = {_ in Player.O} <^> oneOf("oO0")
private let parsePlayer = tokens("1:v1:") *> (parsePlayerO <|> parsePlayerX)

// Fields parsing
private let parseField = fieldify <^> parsePlayer <*> parseX <* char("e") <*> parseY <* char("e")
private let parseFields = char("d") *> parseField <* char("e")

// Boards parsing
private let parseBencodeListBoard = char("l") *> zeroOrMore(parseFields) <* char("e")

func parseBencodeList(msg: String) -> Board? {
    return try? parse(parseBencodeListBoard, msg)
}