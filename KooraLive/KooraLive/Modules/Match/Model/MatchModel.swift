//
//  MatchModel.swift
//  KooraLive
//
//  Created by Dalia on 22/04/2024.
//

import Foundation

struct MatchDay {
    let date: String
    let matches: [Match]
}

struct MatchModel: Codable {
    let count: Int?
    let competition: Competition?
    let matches: [Match]?
}

struct Competition: Codable {
    let id: Int?
    let area: Area?
    let name, code, plan: String?
    let lastUpdated: String?
}

struct Area: Codable {
    let id: Int?
    let name: String?
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
}

struct Odds: Codable {
    let msg: String?
}

struct Referee: Codable {
    let id: Int?
    let name: String?
    let role: String?
    let nationality: String?
}

struct Score: Codable {
    let winner: String?
    let duration: String?
    let fullTime, halfTime, extraTime, penalties: ExtraTime?
}

struct ExtraTime: Codable {
    let homeTeam, awayTeam: Int?
}

struct Season: Codable {
    let id: Int?
    let startDate, endDate: String?
    let currentMatchday: Int?
}

struct Team: Codable {
    let id: Int
    let name: String
}
