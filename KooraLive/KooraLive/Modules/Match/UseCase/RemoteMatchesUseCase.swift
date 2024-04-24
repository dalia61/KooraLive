//
//  RemoteMatchUseCase.swift
//  KooraLive
//
//  Created by Dalia on 22/04/2024.
//

import Foundation

protocol RemoteMatchesUseCaseProtocol {
    func execute(completion: @escaping ([MatchDay]) -> Void)
}

struct RemoteMatchesUseCase: RemoteMatchesUseCaseProtocol {
    private var networkManager: NetworkProtocol
    
    init() {
        self.networkManager = AlamofireManager()
    }

    func execute(completion: @escaping ([MatchDay]) -> Void) {
        var days: [MatchDay] = []

        networkManager.callRequest(MatchModel.self, endpoint: MatchEndPoint.match) { result in
            switch result {
            case let .success(response):
                var matches: [SavedMatchModel] = []
                for match in response.matches ?? [] {
                    let savedMatch = SavedMatchModel()

                    savedMatch.id = match.id ?? 0
                    savedMatch.utcDate = match.utcDate ?? ""
                    savedMatch.homeTeamName = match.homeTeam?.name ?? ""
                    savedMatch.awayTeamName = match.awayTeam?.name ?? ""
                    savedMatch.homeTeamcrest = match.homeTeam?.crest ?? ""
                    savedMatch.awayTeamcrest = match.awayTeam?.crest ?? ""
                    savedMatch.homeTeamFullTime = match.score?.fullTime?.home ?? 0
                    savedMatch.awayTeamFullTime = match.score?.fullTime?.away ?? 0

                    matches.append(savedMatch)
                }
                days = MatchesUtils.groupMatchesByDate(matches: matches)
                completion(days)
            case .failure:
                completion([])
            }
        }
    }    
}
