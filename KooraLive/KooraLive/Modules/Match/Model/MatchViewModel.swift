//
//  MatchCellViewModel.swift
//  KooraLive
//
//  Created by Dalia on 23/04/2024.
//

import Foundation
import RealmSwift

struct MatchViewModel {
    var id: Int
    var utcDate: String
    var homeTeamName: String
    var awayTeamName: String
    var awayTeamcrest: String
    var homeTeamcrest: String
    var fullTime: (homeTeam: Int?, awayTeam: Int?)

    init(id: Int,
         utcDate: String,
         homeTeamName: String,
         awayTeamName: String,
         awayTeamcrest: String,
         homeTeamcrest: String,
         fullTime: (homeTeam: Int?, awayTeam: Int?)) {
        self.id = id
        self.utcDate = utcDate
        self.homeTeamName = homeTeamName
        self.awayTeamName = awayTeamName
        self.awayTeamcrest = awayTeamcrest
        self.homeTeamcrest = homeTeamcrest
        self.fullTime = (
            fullTime.homeTeam ?? 0,
            fullTime.awayTeam ?? 0
        )
    }
}

class SavedMatchModel: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var utcDate: String = ""
    @objc dynamic var homeTeamName: String = ""
    @objc dynamic var awayTeamName: String = ""
    @objc dynamic var awayTeamcrest: String = ""
    @objc dynamic var homeTeamcrest: String = ""
    @objc dynamic var awayTeamFullTime: Int = 0
    @objc dynamic var homeTeamFullTime: Int = 0
}
