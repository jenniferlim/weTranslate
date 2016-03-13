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

    private let searchNavigationController: UINavigationController = {
        let searchNavigationController = UINavigationController()
        searchNavigationController.tabBarItem.image = UIImage(named: "search")
        searchNavigationController.tabBarItem.title = localize("SETTINGS")
        return searchNavigationController
    }()

    private let favoriteNavigationController: UINavigationController = {
        let favoriteNavigationController = UINavigationController()
        favoriteNavigationController.tabBarItem.image = UIImage(named: "star")
        favoriteNavigationController.tabBarItem.title = localize("FAVORITES")
        return favoriteNavigationController
    }()

    private let settingsNavigationController: UINavigationController = {
        let settingsNavigationController = UINavigationController()
        settingsNavigationController.tabBarItem.image = UIImage(named: "settings")
        settingsNavigationController.tabBarItem.title = localize("SETTINGS")
        return settingsNavigationController
    }()

    static let configuration: NSDictionary = {
        let path = NSBundle.mainBundle().pathForResource("Configuration", ofType: "plist")!
        return NSDictionary(contentsOfFile: path)!
    }()

    private lazy var client: Client = {
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

    func startSearch(navigationController: UINavigationController) {
        let searchCoordinator = SearchCoordinator(navigationController: navigationController, client: client)
        searchCoordinator.start()
        childCoordinators.append(searchCoordinator)
    }

    func startFavorite(navigationController: UINavigationController) {
        let favoriteCategoryCoordinator = FavoriteCategoriesCoordinator(navigationController: navigationController)
        favoriteCategoryCoordinator.start()
        childCoordinators.append(favoriteCategoryCoordinator)
    }

    func startSettings(navigationController: UINavigationController) {
        // FIXME
    }
}
