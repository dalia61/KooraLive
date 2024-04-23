//
//  MatchPresenter.swift
//  KooraLive
//
//  Created by Dalia on 22/04/2024.
//

import Foundation

class MatchPresenter: MatchInputProtocol {
    private let coordinator: MatchCoordinator
    
    init(coordinator: MatchCoordinator) {
        self.coordinator = coordinator
    weak var output: MatchOutputProtocol?
    
    private var remoteMatchesUseCase: MatchesUseCaseProtocol
    private var addMatchUseCase: AddMatchUseCaseProtocol
    
    private var matches: [MatchDay] = []

    init(coordinator: MatchCoordinator) {
        self.coordinator = coordinator
        self.remoteMatchesUseCase = MatchesUseCase()
        self.addMatchUseCase = AddMatchUseCase()
    }

    func viewDidLoad() {
        remoteMatchesUseCase.execute { [weak self] matches in
            self?.matches = matches
            self?.output?.reloadData()
        }

    }
    
    func addMatch(section: Int, index: Int) {
        let match = matchItem(section: section, row: index)
        if true {
            addMatchUseCase.execute(match: match)
        } else {
            addMatchUseCase.execute(match: match)
        }
    }
    
    func numberOfDays() -> Int {
        matches.count
    }
    
    func titleForSection(section: Int) -> String {
        matches[section].date
    }
    
    func numberOfMatches(section: Int) -> Int {
        matches[section].matches.count
    }
    
    func matchItem(section: Int, row: Int) -> MatchViewModel {
        let match = matches[section].matches[row]
        return MatchViewModel(utcDate: match.utcDate ?? "",
                              homeTeamName: match.homeTeam?.name ?? "",
                              awayTeamName: match.awayTeam?.name ?? "",
                              fullTime: (match.score?.fullTime?.homeTeam ?? 0,
                                         match.score?.fullTime?.awayTeam ?? 0))
    }

}
