//
//  MatchCellViewModel.swift
//  KooraLive
//
//  Created by Dalia on 23/04/2024.
//

import Foundation
import RealmSwift

struct MatchViewModel {
    var utcDate: String
    var homeTeamName: String
    var awayTeamName: String
    var fullTime: (homeTeam: Int?, awayTeam: Int?)

    init(utcDate: String,
         homeTeamName: String,
         awayTeamName: String,
         fullTime: (homeTeam: Int?, awayTeam: Int?)) {
        self.utcDate = utcDate
        self.homeTeamName = homeTeamName
        self.awayTeamName = awayTeamName
        self.fullTime = (
            fullTime.homeTeam ?? 0,
            fullTime.awayTeam ?? 0
        )
    }
}

class SavedMatchModel: Object {
    @objc dynamic var utcDate: String = ""
    @objc dynamic var homeTeamName: String = ""
    @objc dynamic var awayTeamName: String = ""
    @objc dynamic var awayTeamFullTime: Int = 0
    @objc dynamic var homeTeamFullTime: Int = 0
}
