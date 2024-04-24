//
//  LocalMatchesUseCase.swift
//  KooraLive
//
//  Created by Dalia on 24/04/2024.
//

import Foundation

protocol LocalMatchesUseCaseProtocol {
    func execute() -> [MatchDay]
}

struct LocalMatchesUseCase: LocalMatchesUseCaseProtocol {
    func execute() -> [MatchDay] {
        let matches =  RealmManager.shared.retrieveAllDataForObject(SavedMatchModel.self).map {
            $0
        }
    
        let days = MatchesUtils.groupMatchesByDate(matches: matches)
        return days
    }
}
