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

    let navigationController: NavigationController
    let client: Client
    var childCoordinators: [CoordinatorType] = []

    // MARK: - Initialization

    init(navigationController: NavigationController, client: Client) {
        self.navigationController = navigationController
        self.client = client
    }

    // MARK: - Start

    func start() {
        navigationController.pushViewController(SearchViewController(delegate: self), animated: false)
    }
}

extension SearchCoordinator: SearchViewControllerDelegate {

    func searchViewController(_ searchViewController: SearchViewController, didSearchWord word: String, fromLanguage: Language, toLanguage: Language) {

        client.translate(word: word, from: fromLanguage, to: toLanguage) { result in
            switch result {
            case .success(let translation):
                if let translation = translation {
                    let translationViewModel = TranslationViewModel(translation: translation)
                    searchViewController.state = .result(translationViewModel)

                    // FIX ME: Get rid of it
                    // Display translation only if in favorite or last 20 researches
                    let favoriteCategoryStore = FavoriteCategoryStore()
                    favoriteCategoryStore.insert(translation)
                } else {
                    let noResultViewModel = NoResultViewModel(searchText: word, fromLanguage: fromLanguage, toLanguage: toLanguage)
                    searchViewController.state = .noResult(noResultViewModel)
                }
            case .failure:
                searchViewController.state = .error
            }
        }
    }
}
