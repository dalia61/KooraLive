//
//  DeleteMatchUseCase.swift
//  KooraLive
//
//  Created by Dalia on 24/04/2024.
//

import Foundation

protocol DeleteMatchUseCaseProtocol {
    func execute(matchId: Int)
}

struct DeleteMatchUseCase: DeleteMatchUseCaseProtocol {
    func execute(matchId: Int) {
        let idCell = NSPredicate(format: "%@", matchId)
        RealmManager.shared.delete(SavedMatchModel.self, with: idCell)
    }
}
