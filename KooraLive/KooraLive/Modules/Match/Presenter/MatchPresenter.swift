//
//  MatchPresenter.swift
//  KooraLive
//
//  Created by Dalia on 22/04/2024.
//

import Foundation

class MatchPresenter: MatchInputProtocol {
    var isShowingRemoteMatches: Bool = true

    private let coordinator: MatchCoordinator
    
    weak var output: MatchOutputProtocol?
    
    private var remoteMatchesUseCase: RemoteMatchesUseCaseProtocol
    private var localMatchesUseCase: LocalMatchesUseCaseProtocol
    private var addMatchUseCase: AddMatchUseCaseProtocol
    private var deleteMatchUseCase: DeleteMatchUseCaseProtocol
    private var isMatchAddedUseCase: IsMatchAddedUseCaseProtocol

    private var matches: [MatchDay] = []

    init(coordinator: MatchCoordinator) {
        self.coordinator = coordinator
        self.remoteMatchesUseCase = RemoteMatchesUseCase()
        self.localMatchesUseCase = LocalMatchesUseCase()
        self.addMatchUseCase = AddMatchUseCase()
        self.deleteMatchUseCase = DeleteMatchUseCase()
        self.isMatchAddedUseCase = IsMatchAddedUseCase()
    }

    func addMatch(section: Int, index: Int) {
        let match = matchItem(section: section, row: index)
        if isMatchAddedUseCase.execute(matchId: match.id) {
            deleteMatchUseCase.execute(matchId: match.id)
            if !isShowingRemoteMatches {
                getFavouriteMatches()
            }
        } else {
            addMatchUseCase.execute(match: match)
        }
        self.output?.reloadData()
    }
    
    func numberOfDays() -> Int {
        matches.count
    }
    
    func titleForSection(section: Int) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from: matches[section].date)
        dateFormatter.dateFormat = "MMM d, yyyy"
        return dateFormatter.string(from: date!)
    }
    
    func numberOfMatches(section: Int) -> Int {
        matches[section].matches.count
    }
    
    func matchItem(section: Int, row: Int) -> MatchViewModel {
        let match = matches[section].matches[row]
        return MatchViewModel(id: match.id,
                              isInFavorites: isMatchAddedUseCase.execute(matchId: match.id),
                              utcDate: match.utcDate,
                              homeTeamName: match.homeTeamName,
                              awayTeamName: match.awayTeamName,
                              awayTeamcrest: match.awayTeamcrest,
                              homeTeamcrest: match.homeTeamcrest,
                              fullTime: (match.homeTeamFullTime,
                                         match.awayTeamFullTime))
    }
}

extension MatchPresenter {
    func getRemoteMatches() {
        remoteMatchesUseCase.execute { [weak self] matches in
            self?.matches = matches
            self?.output?.reloadData()
        }
    }
    
    func getFavouriteMatches() {
        self.matches = localMatchesUseCase.execute()
        self.output?.reloadData()
    }
}
