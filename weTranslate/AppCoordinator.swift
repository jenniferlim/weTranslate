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

    // MARK: - Initialization

    init(rootViewController: TabBarController) {
        self.rootViewController = rootViewController
    }

    // MARK: - Methods

    func start() {
        let searchNavigationController = UINavigationController()
        rootViewController.viewControllers = [
            searchNavigationController
        ]

        showSearch(searchNavigationController)
    }

    func showSearch(navigationController: UINavigationController) {
        let searchCoordinator = SearchCoordinator(navigationController: navigationController)
        searchCoordinator.start()
        rootViewController.selectedIndex = 0
        childCoordinators.append(searchCoordinator)
    }
}
