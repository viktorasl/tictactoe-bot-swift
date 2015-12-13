//
//  main.swift
//  tictactoe-swift
//
//  Created by Viktoras Laukevičius on 12/12/15.
//
//

import Foundation

if let parsed = parseBencodeDict("d1:0d1:v1:x1:xi0e1:yi0ee1:1d1:v1:o1:xi2e1:yi0ee1:2d1:v1:x1:xi0e1:yi1ee1:3d1:v1:o1:xi2e1:yi2ee1:4d1:v1:x1:xi0e1:yi2eee") {
    print(encodeBencodeDict(parsed))
} else {
    print("error occured parsing board")
}

let attReq = TictactoeReq(player: .X, gameName: "sw-3", contentType: .BencodeList)
makeMove(attReq, boardStr: encodeBencodeList([BoardField(x: 1, y: 1, player: .X)]))

let defReq = TictactoeReq(player: .O, gameName: "sw-3", contentType: .BencodeDict)
print(getMove(defReq))
