//
//  MatchCoordinator.swift
//  KooraLive
//
//  Created by Dalia on 22/04/2024.
//

import UIKit

class MatchCoordinator: Coordinator {
    let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
            let matchPresenter = MatchPresenter(coordinator: self)
            let matchViewController = MatchViewController(presenter: matchPresenter)
            matchPresenter.output = matchViewController
            navigationController.setViewControllers([matchViewController], animated: false)
        }
}
