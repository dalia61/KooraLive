//
//  IsMatchAddedUseCase.swift
//  KooraLive
//
//  Created by Dalia on 24/04/2024.
//

import Foundation

protocol IsMatchAddedUseCaseProtocol {
    func execute(matchId: Int) -> Bool
}

struct IsMatchAddedUseCase: IsMatchAddedUseCaseProtocol {
    func execute(matchId: Int) -> Bool {
        let favorites = RealmManager.shared.retrieveAllDataForObject(SavedMatchModel.self)
        return favorites.contains { $0.id == matchId }
    }
}
