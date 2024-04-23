//
//  MatchPresenter.swift
//  KooraLive
//
//  Created by Dalia on 22/04/2024.
//

import Foundation

class MatchPresenter {
    private let coordinator: MatchCoordinator
    private var networkManager: AlamofireManager
    private var matches: [Match] = []
    weak var output: MatchOutputProtocol?

    init(coordinator: MatchCoordinator, networkManager: AlamofireManager) {
        self.coordinator = coordinator
        self.networkManager = networkManager
    }

    func fetchMatches() {
        networkManager.callRequest([Match].self, endpoint: MatchEndPoint.match) { [weak self] result in
            switch result {
            case let .success(response):
                self?.output?.matchesResult(match: response)
            case let .failure(error):
                print(error)
            }
        }
    }
}
