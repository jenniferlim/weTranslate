//
//  AppCoordinator.swift
//  weTranslate
//
//  Created by Lionel on 2/13/16.
//  Copyright © 2016 weTranslate. All rights reserved.
//

import UIKit

final class AppCoordinator: CoordinatorType {

    // MARK: - Properties

    let rootViewController: TabBarController
    var childCoordinators: [CoordinatorType] = []

    private let searchNavigationController: UINavigationController = {
        let searchNavigationController = UINavigationController()
        searchNavigationController.tabBarItem.image = UIImage(named: "search")
        searchNavigationController.tabBarItem.title = "Search"
        return searchNavigationController
    }()

    private let favoriteNavigationController: UINavigationController = {
        let favoriteNavigationController = UINavigationController()
        favoriteNavigationController.tabBarItem.image = UIImage(named: "star")
        favoriteNavigationController.tabBarItem.title = "Favorite"
        return favoriteNavigationController
    }()
    
    private let settingsNavigationController: UINavigationController = {
        let settingsNavigationController = UINavigationController()
        settingsNavigationController.tabBarItem.image = UIImage(named: "settings")
        settingsNavigationController.tabBarItem.title = "Settings"
        return settingsNavigationController
    }()

    // MARK: - Initialization

    init(rootViewController: TabBarController) {
        self.rootViewController = rootViewController
    }

    // MARK: - Methods

    func start() {
        rootViewController.viewControllers = [
            searchNavigationController,
            favoriteNavigationController,
            settingsNavigationController
        ]

        startSearch(searchNavigationController)
        startFavorite(favoriteNavigationController)
        startSettings(settingsNavigationController)
        
        rootViewController.selectedIndex = 0
    }

    func startSearch(navigationController: UINavigationController) {
        let searchCoordinator = SearchCoordinator(navigationController: navigationController)
        searchCoordinator.start()
        childCoordinators.append(searchCoordinator)
    }
    
    func startFavorite(navigationController: UINavigationController) {
        // FIXME
    }
    
    func startSettings(navigationController: UINavigationController) {
        // FIXME
    }
}
