//
//  decode.swift
//  tictactoe-swift
//
//  Created by Viktoras Laukevičius on 13/12/15.
//
//

import FootlessParser

private func fieldify(player: Player)(x: UInt)(y: UInt) -> BoardField {
    return BoardField(x: x, y: y, player: player)
}

// Coordinates parsing
private let parseX = {UInt("\($0)")!} <^> (tokens("1:xi") *> oneOf("012"))
private let parseY = {UInt("\($0)")!} <^> (tokens("1:yi") *> oneOf("012"))

// Players parsing
private let parsePlayerX = {_ in Player.X} <^> oneOf("xX")
private let parsePlayerO = {_ in Player.O} <^> oneOf("oO0")
private let parsePlayer = tokens("1:v1:") *> (parsePlayerO <|> parsePlayerX)

// Fields parsing
private let parseField = fieldify <^> parsePlayer <*> parseX <* char("e") <*> parseY <* char("e")
private let parseFieldDict = char("d") *> parseField <* char("e")
private let parseDictFields = char("1") *> char(":") *> oneOf("0123456789") *> parseFieldDict

// Boards parsing
private let parseBencodeListBoard = char("l") *> zeroOrMore(parseFieldDict) <* char("e")
private let parseBencodeDictBoard = char("d") *> zeroOrMore(parseDictFields) <* char("e")

public func parseBencodeList(msg: String) -> Board? {
    if let fields = try? parse(parseBencodeListBoard, msg) {
        return Board(fields: fields)
    } else {
        return nil
    }
}

func parseBencodeDict(msg: String) -> Board? {
    if let fields = try? parse(parseBencodeDictBoard, msg) {
        return Board(fields: fields)
    } else {
        return nil
    }
}
