//
//  SettingsCoordinator.swift
//  weTranslate
//
//  Created by Joe Levin on 2/27/16.
//  Copyright © 2016 weTranslate. All rights reserved.
//

import UIKit

final class SettingsCoordinator: CoordinatorType {
    
    // MARK: - Properties
    let navigationController: UINavigationController
    var childCoordinators: [CoordinatorType] = []
    
    // MARK: - Initialization
    init(navigationController: UINavigationController)
    {
        self.navigationController = navigationController;
    }
    
    func start() {
        navigationController.pushViewController(SettingsViewController(), animated: true)
    }
}
