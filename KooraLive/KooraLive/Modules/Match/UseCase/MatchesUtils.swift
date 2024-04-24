//
//  MatchesUtils.swift
//  KooraLive
//
//  Created by Dalia on 24/04/2024.
//

import Foundation

struct MatchesUtils {
    static func groupMatchesByDate(matches: [SavedMatchModel]) -> [MatchDay] {
        var matchDays: [MatchDay] = []
        var matchesByDate: [String: [SavedMatchModel]] = [:]

        for match in matches {
            let date = match.utcDate.prefix(10)
            let dateString = String(date)
            matchesByDate[dateString, default: []].append(match)
        }

        let today = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let todayDateString = dateFormatter.string(from: today)

        matchDays = matchesByDate.map { MatchDay(date: $0.key, matches: $0.value) }
        matchDays.sort { matchDay1, matchDay2 in
            if matchDay1.date == todayDateString {
                return true
            } else if matchDay1.date != todayDateString && matchDay2.date == todayDateString {
                return false
            } else {
                return matchDay1.date < matchDay2.date
            }
        }
        return matchDays
    }
}
