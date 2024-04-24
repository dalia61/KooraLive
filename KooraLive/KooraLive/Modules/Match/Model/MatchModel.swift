//
//  MatchModel.swift
//  KooraLive
//
//  Created by Dalia on 22/04/2024.
//

import Foundation

struct MatchDay {
    let date: String
    let matches: [SavedMatchModel]
}

struct MatchModel: Codable {
    let filters: Filters?
    let competition: Competition?
    let matches: [Match]?
}

struct Competition: Codable {
    let id: Int?
    let name, code, type: String?
    let emblem: String?
}

struct Filters: Codable {
    let season: String?
}

struct Match: Codable {
    let id: Int?
    let season: Season?
    let utcDate: String?
    let status: String?
    let matchday: Int?
    let stage: String?
    let group: String?
    let lastUpdated: String?
    let odds: Odds?
    let score: Score?
    let homeTeam, awayTeam: Team?
    let referees: [Referee]?
    let area: Area?
    let competition: Competition?
}

struct Area: Codable {
    let id: Int?
    let name: String?
    let code: String?
    let flag: String?
}

struct Team: Codable {
    let id: Int
    let name: String?
    let shortName: String?
    let tla:String?
    let crest: String?

}

struct Odds: Codable {
    let msg: String?
}

struct Referee: Codable {
    let id: Int?
    let name: String?
    let type: String?
    let nationality: String?
}

struct Score: Codable {
    let winner: String?
    let duration: String?
    let fullTime, halfTime: Time?
}

struct Time: Codable {
    let home, away: Int?
}

struct Season: Codable {
    let id: Int?
    let startDate, endDate: String?
    let currentMatchday: Int?
}
