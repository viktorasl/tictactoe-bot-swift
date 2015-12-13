//
//  main.swift
//  tictactoe-swift
//
//  Created by Viktoras Laukevičius on 12/12/15.
//
//

if let parsed = parseBencodeList("ld1:v1:x1:xi0e1:yi0eed1:v1:o1:xi2e1:yi0eed1:v1:x1:xi0e1:yi1eed1:v1:o1:xi1e1:yi1eed1:v1:x1:xi0e1:yi2eee") {
    print(encodeBencodeList(parsed))
} else {
    print("error occured parsing board")
}
