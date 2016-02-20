//
//  SearchCoordinator.swift
//  weTranslate
//
//  Created by Lionel on 2/14/16.
//  Copyright © 2016 weTranslate. All rights reserved.
//

import UIKit

import TranslateKit

protocol SearchViewControllerDelegate: class {
    func searchViewController(searchViewController: SearchViewController, didSearchWord word: String)
}

final class SearchCoordinator: CoordinatorType {

    let navigationController: UINavigationController
    var childCoordinators: [CoordinatorType] = []

    // MARK: - Initialization

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    // MARK: - Start

    func start() {
        navigationController.pushViewController(SearchViewController(delegate: self), animated: false)
    }
}

extension SearchCoordinator: SearchViewControllerDelegate {
    func searchViewController(searchViewController: SearchViewController, didSearchWord word: String) {
        let client = Client(wordReferenceApiKey: "API_KEY")
        
        client.translate(word: word, from: .English, to: .French) { translation in
            if let translation = translation {
                let searchViewModel = SearchViewModel(translation: translation)
                searchViewController.viewModel = searchViewModel
            }
        }
    }
}
