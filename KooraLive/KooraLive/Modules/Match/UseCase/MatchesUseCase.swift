//
//  MatchUseCase.swift
//  KooraLive
//
//  Created by Dalia on 22/04/2024.
//

import Foundation

protocol MatchesUseCaseProtocol {
    func execute(completion: @escaping ([MatchDay]) -> Void)
    func getFavourite() -> [SavedMatchModel]
}

struct MatchesUseCase: MatchesUseCaseProtocol {
    private var networkManager: NetworkProtocol
    
    init() {
        self.networkManager = AlamofireManager()
    }

    func execute(completion: @escaping ([MatchDay]) -> Void) {
        var days: [MatchDay] = []

        networkManager.callRequest(MatchModel.self, endpoint: MatchEndPoint.match) { result in
            switch result {
            case let .success(response):
                days = groupMatchesByDate(matches: response.matches ?? [])
                completion(days)
            case .failure:
                completion([])
            }
        }
    }
    
    func getFavourite() -> [SavedMatchModel] {
        return RealmManager.shared.retrieveAllDataForObject(SavedMatchModel.self)
    }
    
    private func groupMatchesByDate(matches: [Match]) -> [MatchDay] {
        var matchDays: [MatchDay] = []
        var matchesByDate: [String: [Match]] = [:]

        for match in matches {
            if let date = match.utcDate?.prefix(10) {
                let dateString = String(date)
                matchesByDate[dateString, default: []].append(match)
            }
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
