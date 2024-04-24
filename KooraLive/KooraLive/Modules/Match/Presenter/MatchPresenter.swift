//
//  MatchPresenter.swift
//  KooraLive
//
//  Created by Dalia on 22/04/2024.
//

import Foundation

class MatchPresenter: MatchInputProtocol {
    private let coordinator: MatchCoordinator
    
    weak var output: MatchOutputProtocol?
    
    private var remoteMatchesUseCase: MatchesUseCaseProtocol
    private var addMatchUseCase: AddMatchUseCaseProtocol
    private var deleteMatchUseCase: DeleteMatchUseCaseProtocol
    
    private var matches: [MatchDay] = []
    
    init(coordinator: MatchCoordinator) {
        self.coordinator = coordinator
        self.remoteMatchesUseCase = MatchesUseCase()
        self.addMatchUseCase = AddMatchUseCase()
        self.deleteMatchUseCase = DeleteMatchUseCase()
    }
    
    func viewDidLoad() {
        remoteMatchesUseCase.execute { [weak self] matches in
            self?.matches = matches
            self?.output?.reloadData()
        }
        
    }
    
    func addMatch(section: Int, index: Int) {
        let match = matchItem(section: section, row: index)
        if matchIsAlreadyFavorited(matchId: match.id) {
            deleteMatchUseCase.execute(matchId: match.id)
        } else {
            addMatchUseCase.execute(match: match)
        }
    }

    func matchIsAlreadyFavorited(matchId: Int) -> Bool {
        let favorites = RealmManager.shared.retrieveAllDataForObject(SavedMatchModel.self)
        return favorites.contains { $0.id == matchId }
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
        return MatchViewModel(id: match.id ?? 0, utcDate: match.utcDate ?? "",
                              homeTeamName: match.homeTeam?.name ?? "",
                              awayTeamName: match.awayTeam?.name ?? "",
                              awayTeamcrest: match.awayTeam?.crest ?? "",
                              homeTeamcrest: match.homeTeam?.crest ?? "",
                              fullTime: (match.score?.fullTime?.homeTeam ?? 0,
                                         match.score?.fullTime?.awayTeam ?? 0))
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
        remoteMatchesUseCase.getFavourite { [weak self] favoriteMatches in
            //self?.matches.append(favoriteMatches)
            self?.output?.reloadData()
        }
    }
}
