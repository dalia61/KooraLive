//
//  AppCoordinator.swift
//  KooraLive
//
//  Created by Dalia on 22/04/2024.
//

import UIKit

protocol Coordinator: AnyObject {
    var navigationController: UINavigationController { get }
    func start()
}

final class AppCoordinator {
    private let window: UIWindow
    private var children: [Coordinator] = []
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        showAppFlow()
    }
}
private extension AppCoordinator {
    func showAppFlow() {
        let navigationController = UINavigationController()
        let coordinator = MatchCoordinator(navigationController: navigationController)
        coordinator.start()
        children.append(coordinator)
        replaceRootViewController(navigationController)
    }
}
private extension AppCoordinator {
    func replaceRootViewController(_ viewController: UIViewController) {
        window.rootViewController = viewController
        window.makeKeyAndVisible()
    }
}
