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

extension Board: Arbitrary {
    public static func create(x : Int) -> Board {
        return Board(fields: [])
    }
    public static var arbitrary: Gen<Board> {
        return Board.create <^> Int.arbitrary
    }
}

extension BoardField : Arbitrary {
    public static func create(x : UInt) -> UInt -> Player -> BoardField {
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

class TictactoeTests: XCTestCase {
    
    func testExample() {
        property("All board fields has valid coordinates") <- forAll{ (field: BoardField) in
            return field.x <= 2 && field.x >= 0 && field.y <= 2 && field.y >= 0
        }
    }
    
}
