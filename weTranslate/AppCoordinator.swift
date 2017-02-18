//
//  AppCoordinator.swift
//  weTranslate
//
//  Created by Lionel on 2/13/16.
//  Copyright © 2016 weTranslate. All rights reserved.
//

import UIKit
import TranslateKit

final class AppCoordinator: CoordinatorType {

    // MARK: - Properties

    let rootViewController: TabBarController
    var childCoordinators: [CoordinatorType] = []

    fileprivate let searchNavigationController: NavigationController = {
        let searchNavigationController = NavigationController()
        searchNavigationController.tabBarItem.image = UIImage(named: "search")
        searchNavigationController.tabBarItem.title = localize("SETTINGS")
        return searchNavigationController
    }()

    fileprivate let favoriteNavigationController: NavigationController = {
        let favoriteNavigationController = NavigationController()
        favoriteNavigationController.tabBarItem.image = UIImage(named: "star")
        favoriteNavigationController.tabBarItem.title = localize("FAVORITES")
        return favoriteNavigationController
    }()

    fileprivate let settingsNavigationController: NavigationController = {
        let settingsNavigationController = NavigationController()
        settingsNavigationController.tabBarItem.image = UIImage(named: "settings")
        settingsNavigationController.tabBarItem.title = localize("SETTINGS")
        return settingsNavigationController
    }()

    static let configuration: NSDictionary = {
        let path = Bundle.main.path(forResource: "Configuration", ofType: "plist")!
        return NSDictionary(contentsOfFile: path)!
    }()

    fileprivate lazy var client: Client = {
        let APIKey = AppCoordinator.configuration["API_KEY"] as? String ?? "API_KEY"
        return Client(wordReferenceApiKey: APIKey)
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

    func startSearch(_ navigationController: NavigationController) {
        let searchCoordinator = SearchCoordinator(navigationController: navigationController, client: client)
        searchCoordinator.start()
        childCoordinators.append(searchCoordinator)
    }

    func startFavorite(_ navigationController: NavigationController) {
        let favoriteCategoryCoordinator = FavoriteCategoriesCoordinator(navigationController: navigationController)
        favoriteCategoryCoordinator.start()
        childCoordinators.append(favoriteCategoryCoordinator)
    }

    func startSettings(_ navigationController: NavigationController) {
        // FIXME
    }
}
