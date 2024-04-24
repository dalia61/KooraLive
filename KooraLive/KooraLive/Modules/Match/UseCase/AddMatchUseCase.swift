//
//  AddMatchUseCase.swift
//  KooraLive
//
//  Created by Dalia on 23/04/2024.
//

import Foundation

protocol AddMatchUseCaseProtocol {
    func execute(match: MatchViewModel)
}

struct AddMatchUseCase: AddMatchUseCaseProtocol {
    func execute(match: MatchViewModel) {
        let savedMatch = SavedMatchModel()
        savedMatch.id = match.id
        savedMatch.utcDate = match.utcDate
        savedMatch.awayTeamName = match.awayTeamName
        savedMatch.homeTeamName = match.homeTeamName
        savedMatch.homeTeamFullTime = match.fullTime.homeTeam ?? 0
        savedMatch.awayTeamFullTime = match.fullTime.awayTeam ?? 0

        RealmManager.shared.add(savedMatch)
    }
}
