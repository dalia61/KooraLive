//
//  MatchModel.swift
//  KooraLive
//
//  Created by Dalia on 22/04/2024.
//

import Foundation

// MARK: - MatchModel
struct MatchModel: Codable {
    let count: Int
    let filters: Filters
    let competition: Competition
    let matches: [Match]
}

// MARK: - Competition
struct Competition: Codable {
    let id: Int
    let area: Area
    let name, code, plan: String
    let lastUpdated: Date
}

// MARK: - Area
struct Area: Codable {
    let id: Int
    let name: Name
}

enum Name: String, Codable {
    case afcBournemouth = "AFC Bournemouth"
    case arsenalFC = "Arsenal FC"
    case astonVillaFC = "Aston Villa FC"
    case brentfordFC = "Brentford FC"
    case brightonHoveAlbionFC = "Brighton & Hove Albion FC"
    case burnleyFC = "Burnley FC"
    case chelseaFC = "Chelsea FC"
    case crystalPalaceFC = "Crystal Palace FC"
    case england = "England"
    case evertonFC = "Everton FC"
    case fulhamFC = "Fulham FC"
    case liverpoolFC = "Liverpool FC"
    case lutonTownFC = "Luton Town FC"
    case manchesterCityFC = "Manchester City FC"
    case manchesterUnitedFC = "Manchester United FC"
    case newcastleUnitedFC = "Newcastle United FC"
    case nottinghamForestFC = "Nottingham Forest FC"
    case sheffieldUnitedFC = "Sheffield United FC"
    case tottenhamHotspurFC = "Tottenham Hotspur FC"
    case westHamUnitedFC = "West Ham United FC"
    case wolverhamptonWanderersFC = "Wolverhampton Wanderers FC"
}

// MARK: - Filters
struct Filters: Codable {
}

// MARK: - Match
struct Match: Codable {
    let id: Int
    let season: Season
    let utcDate: Date
    let status: Status
    let matchday: Int
    let stage: Stage
    let group: JSONNull?
    let lastUpdated: Date
    let odds: Odds
    let score: Score
    let homeTeam, awayTeam: Area
    let referees: [Referee]
}

// MARK: - Odds
struct Odds: Codable {
    let msg: Msg
}

enum Msg: String, Codable {
    case activateOddsPackageInUserPanelToRetrieveOdds = "Activate Odds-Package in User-Panel to retrieve odds."
}

// MARK: - Referee
struct Referee: Codable {
    let id: Int
    let name: String
    let role: Role
    let nationality: Nationality
}

enum Nationality: String, Codable {
    case australia = "Australia"
    case england = "England"
}

enum Role: String, Codable {
    case referee = "REFEREE"
}

// MARK: - Score
struct Score: Codable {
    let winner: Winner?
    let duration: Duration
    let fullTime, halfTime, extraTime, penalties: ExtraTime
}

enum Duration: String, Codable {
    case regular = "REGULAR"
}

// MARK: - ExtraTime
struct ExtraTime: Codable {
    let homeTeam, awayTeam: Int?
}

enum Winner: String, Codable {
    case awayTeam = "AWAY_TEAM"
    case draw = "DRAW"
    case homeTeam = "HOME_TEAM"
}

// MARK: - Season
struct Season: Codable {
    let id: Int
    let startDate, endDate: String
    let currentMatchday: Int
}

enum Stage: String, Codable {
    case regularSeason = "REGULAR_SEASON"
}

enum Status: String, Codable {
    case finished = "FINISHED"
    case scheduled = "SCHEDULED"
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
