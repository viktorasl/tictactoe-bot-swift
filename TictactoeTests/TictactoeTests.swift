//
//  TictactoeTests.swift
//  TictactoeTests
//
//  Created by Viktoras Laukevičius on 13/12/15.
//
//

import XCTest
import SwiftCheck

extension Player: Arbitrary {
    public static var arbitrary: Gen<Player> {
        return Gen.oneOf([Gen.pure(Player.X), Gen.pure(Player.O)])
    }
}

extension BoardField: Arbitrary {
    public static func create(x: UInt) -> UInt -> Player -> BoardField {
        return { y in
            { player in
                BoardField(x: x % 3, y: y % 3, player: player)
            }
        }
    }
    public static var arbitrary: Gen<BoardField> {
        return BoardField.create <^> UInt.arbitrary <*> UInt.arbitrary <*> Player.arbitrary
    }
}

extension Board: Arbitrary {
    public static func create(count: UInt) -> Board {
        return Board(fields: [0..<(count%10)].map{ _ in BoardField.arbitrary.generate })
    }
    public static var arbitrary: Gen<Board> {
        return Board.create <^> UInt.arbitrary
    }
}

extension BoardField: Equatable { }
public func ==(left: BoardField, right: BoardField) -> Bool {
    return left.x == right.x &&
        left.y == right.y &&
        left.player == right.player
}

func ==(left: Board, right: Board) -> Bool {
    return left.fields == right.fields
}

class TictactoeTests: XCTestCase {
    
    func testExample() {
        property("All board fields has valid coordinates") <- forAll{ (field: BoardField) in
            return field.x <= 2 && field.x >= 0 && field.y <= 2 && field.y >= 0
        }
        property("Decoded bencode list encoded board is that board") <- forAll{ (board: Board) in
            return parseBencodeList(encodeBencodeList(board))! == board
        }
        property("Decoded bencode dictionary encoded board is that board") <- forAll{ (board: Board) in
            return parseBencodeDict(encodeBencodeDict(board))! == board
        }
    }
    
}
