//
//  SearchCoordinator.swift
//  weTranslate
//
//  Created by Lionel on 2/14/16.
//  Copyright © 2016 weTranslate. All rights reserved.
//

import UIKit
import TranslateKit

final class SearchCoordinator: CoordinatorType {

    // MARK: - Properties

    let navigationController: UINavigationController
    let client: Client
    var childCoordinators: [CoordinatorType] = []

    // MARK: - Initialization

    init(navigationController: UINavigationController, client: Client) {
        self.navigationController = navigationController
        self.client = client
    }

    // MARK: - Start

    func start() {
        navigationController.pushViewController(SearchViewController(delegate: self), animated: false)
    }
}

extension SearchCoordinator: SearchViewControllerDelegate {
    func searchViewController(searchViewController: SearchViewController, didSearchWord word: String, fromLanguage: Language, toLanguage: Language) {

        client.translate(word: word, from: fromLanguage, to: toLanguage) { translation in
            guard case .Success(let t) = result, let translation = t else {
                searchViewController.state = .NoResult
                return
            }
            
            let searchViewModel = SearchViewModel(translation: translation)
            searchViewController.state = .Result(searchViewModel)

            // FIX ME: Get rid of it
            // Display translation only if in favorite or last 20 researches
            let favoriteCategoryStore = FavoriteCategoryStore()
            favoriteCategoryStore.insert(translation: translation)
        }
    }
}
