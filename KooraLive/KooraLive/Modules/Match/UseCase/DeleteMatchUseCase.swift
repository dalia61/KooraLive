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
        let idPredicate = NSPredicate(format: "id == %d", matchId)
        RealmManager.shared.delete(SavedMatchModel.self, with: idPredicate)
    }
}
