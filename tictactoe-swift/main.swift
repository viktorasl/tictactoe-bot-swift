//
//  main.swift
//  tictactoe-swift
//
//  Created by Viktoras Laukevičius on 12/12/15.
//
//

import Foundation

let args = Array(Process.arguments[1..<Process.arguments.count])

if args.count < 2 {
    print("Unknown parameters")
    exit(0)
}
guard let player = Player(key: args[0]) else {
    print("Unknown player")
    exit(0)
}
let gameName = args[1]

func playAttacker(req: TictactoeReq, board: Board, moves: Board) {
    if let move = moves.first {
        let newBoard = board + [move]
        makeMove(req, boardStr: encodeBencodeList(newBoard))
    }
    let leftMoves = Array(moves[1..<(moves.count)])
    if leftMoves.count > 0 {
        guard let getResp = getMove(req), gotBoard = parseBencodeList(getResp) else {
            print("Error occured getting board")
            return
        }
        playAttacker(req, board: gotBoard, moves: leftMoves)
    }
}

func playDefender(req: TictactoeReq, board: Board, moves: Board) {
    guard let getResp = getMove(req), gotBoard = parseBencodeDict(getResp) else {
        print("Error occured getting board")
        return
    }
    if let move = moves.first {
        let newBoard = gotBoard + [move]
        makeMove(req, boardStr: encodeBencodeDict(newBoard))
        let leftMoves = Array(moves[1..<(moves.count)])
        playDefender(req, board: newBoard, moves: leftMoves)
    }
}

switch player {
case .X:
    let attMoves = [
        BoardField(x: 1, y: 1, player: .X),
        BoardField(x: 0, y: 2, player: .X),
        BoardField(x: 2, y: 2, player: .X),
        BoardField(x: 1, y: 0, player: .X),
        BoardField(x: 2, y: 1, player: .X)
    ]
    let attReq = TictactoeReq(player: player, gameName: gameName, contentType: .BencodeList)
    playAttacker(attReq, board: [], moves: attMoves)
case .O:
    let defMoves = [
        BoardField(x: 0, y: 0, player: .O),
        BoardField(x: 2, y: 0, player: .O),
        BoardField(x: 1, y: 2, player: .O),
        BoardField(x: 0, y: 1, player: .O)
    ]
    let defReq = TictactoeReq(player: .O, gameName: gameName, contentType: .BencodeDict)
    playDefender(defReq, board: [], moves: defMoves)
}
