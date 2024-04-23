//
//  MatchCellViewModel.swift
//  KooraLive
//
//  Created by Dalia on 23/04/2024.
//

import Foundation

struct MatchCellViewModel {
    let utcDate: Date
    let homeTeamName: String
    let awayTeamName: String
    let fullTime: (homeTeam: Int?, awayTeam: Int?)
    
    init(match: Match) {
        self.utcDate = match.utcDate
        self.homeTeamName = match.homeTeam.name.rawValue
        self.awayTeamName = match.awayTeam.name.rawValue
        self.fullTime = (match.score.fullTime.homeTeam, match.score.fullTime.awayTeam)
    }
}
