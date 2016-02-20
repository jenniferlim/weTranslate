//
//  SearchCoordinator.swift
//  weTranslate
//
//  Created by Lionel on 2/14/16.
//  Copyright © 2016 weTranslate. All rights reserved.
//

import UIKit

final class SearchCoordinator: CoordinatorType {

    // MARK: - Properties

    let navigationController: UINavigationController
    var childCoordinators: [CoordinatorType] = []

    // MARK: - Initialization

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    // MARK: -

    func start() {
        navigationController.pushViewController(SearchViewController(), animated: false)
    }
}
