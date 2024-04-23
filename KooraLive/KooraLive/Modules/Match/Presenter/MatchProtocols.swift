//
//  MatchProtocols.swift
//  KooraLive
//
//  Created by Dalia on 22/04/2024.
//

import Foundation

protocol MatchOutputProtocol: AnyObject {
    func matchesResult(match: [Match])
}

protocol MatchInputProtocol: AnyObject {
    func fetchMatches()
}
