//
//  MatchProtocols.swift
//  KooraLive
//
//  Created by Dalia on 22/04/2024.
//

import Foundation

protocol MatchOutputProtocol: AnyObject {
    func reloadData()
}

protocol MatchInputProtocol: AnyObject {
    func viewDidLoad()
    func addMatch(section: Int, index: Int)
    
    func numberOfDays() -> Int
    func titleForSection(section: Int) -> String
    func numberOfMatches(section: Int) -> Int
    func matchItem(section: Int, row: Int) -> MatchViewModel
    func getRemoteMatches()
    func getFavouriteMatches()
}
