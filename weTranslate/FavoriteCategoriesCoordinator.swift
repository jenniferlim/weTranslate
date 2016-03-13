//
//  FavoritesCoordinator.swift
//  weTranslate
//
//  Created by Jennifer on 27/02/2016.
//  Copyright © 2016 weTranslate. All rights reserved.
//

import UIKit
import TranslateKit

final class FavoriteCategoriesCoordinator: CoordinatorType {

    // MARK: - Properties

    let navigationController: UINavigationController
    var childCoordinators: [CoordinatorType] = []

    // MARK: - Initialization

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    // MARK: - Start

    func start() {
        let favoriteCategories = FavoriteCategoryStore().fetchAll()
        let favoriteCategoriesViewController = FavoriteCategoriesViewController(delegate: self)
        favoriteCategoriesViewController.viewModel = favoriteCategories.map(FavoriteCategoryViewModel.init)
        navigationController.pushViewController(favoriteCategoriesViewController, animated: false)
    }
}

extension FavoriteCategoriesCoordinator: FavoriteCategoriesViewControllerDelegate {
    func favoriteCategoriesViewControllerNeedsUpdate(favoriteCategoriesViewController: FavoriteCategoriesViewController) {
        let favoriteCategories = FavoriteCategoryStore().fetchAll()
        favoriteCategoriesViewController.viewModel = favoriteCategories.map(FavoriteCategoryViewModel.init)
    }

    func favoriteCategoriesViewController(favoriteCategoriesViewController: FavoriteCategoriesViewController, didSelectCategory category: FavoriteCategory) {
        let favoritesViewController = FavoritesViewController()
        favoritesViewController.viewModels = category.translations.map { FavoriteViewModel(translation: $0) }
        navigationController.pushViewController(favoritesViewController, animated: true)
    }
}
