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

        client.translate(word: word, from: fromLanguage, to: toLanguage) { result in
            switch result {
            case .Success(let translation):
                if let translation = translation {
                    let translationViewModel = TranslationViewModel(translation: translation)
                    searchViewController.state = .Result(translationViewModel)

                    // FIX ME: Get rid of it
                    // Display translation only if in favorite or last 20 researches
                    let favoriteCategoryStore = FavoriteCategoryStore()
                    favoriteCategoryStore.insert(translation: translation)
                } else {
                    let noResultViewModel = NoResultViewModel(searchText: word, fromLanguage: fromLanguage, toLanguage: toLanguage)
                    searchViewController.state = .NoResult(noResultViewModel)
                }
            case .Failure:
                searchViewController.state = .Error
            }
        }
    }
}
