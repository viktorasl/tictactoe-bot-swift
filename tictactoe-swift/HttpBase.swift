//
//  HttpBase.swift
//  tictactoe-swift
//
//  Created by Viktoras Laukevičius on 13/12/15.
//
//

import Foundation

let gameHost = "http://tictactoe.homedir.eu/game"

enum HTTPContentType: String {
    case BencodeList = "application/bencode+list"
    case BencodeDict = "application/bencode+map"
}

struct TictactoeReq {
    let player: Player
    let gameName: String
    let contentType: HTTPContentType
    
    var url: NSURL {
        return NSURL(string: "\(gameHost)/\(gameName)/player/\(player.urlKey)")!
    }
}

func makeMove(req: TictactoeReq, boardStr: String) {
    let encoded = boardStr.dataUsingEncoding(NSASCIIStringEncoding)!
    let request = NSMutableURLRequest(URL: req.url)
    request.HTTPMethod = "POST"
    request.HTTPBody = encoded
    request.setValue(req.contentType.rawValue, forHTTPHeaderField: "Content-Type")
    try? NSURLConnection.sendSynchronousRequest(request, returningResponse: nil)
}

func getMove(req: TictactoeReq) -> String? {
    let request = NSMutableURLRequest(URL: req.url)
    request.HTTPMethod = "GET"
    request.setValue(req.contentType.rawValue, forHTTPHeaderField: "Accept")
    if let data = try? NSURLConnection.sendSynchronousRequest(request, returningResponse: nil) {
        return NSString(data: data, encoding: NSUTF8StringEncoding) as? String
    } else {
        return nil
    }
}
