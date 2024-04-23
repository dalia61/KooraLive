//
//  MatchCellViewModel.swift
//  KooraLive
//
//  Created by Dalia on 23/04/2024.
//

import Foundation

struct MatchCellViewModel {
    let utcDate: String
    let homeTeamName: String
    let awayTeamName: String
    let fullTime: (homeTeam: Int?, awayTeam: Int?)
    
    init(match: Match) {
        self.utcDate = match.utcDate ?? ""
        self.homeTeamName = match.homeTeam?.name ?? "Unknown"
        self.awayTeamName = match.awayTeam?.name ?? "Unknown"
        self.fullTime = (
            match.score?.fullTime?.homeTeam ?? 0,
            match.score?.fullTime?.awayTeam ?? 0
        )
    }
}
