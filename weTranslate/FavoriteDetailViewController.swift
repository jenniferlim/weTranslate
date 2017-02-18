//
//  FavoriteDetailViewController.swift
//  weTranslate
//
//  Created by Lionel on 3/13/16.
//  Copyright © 2016 weTranslate. All rights reserved.
//

import UIKit
import TranslateKit

protocol FavoriteDetailViewControllerDelegate: class {

}

final class FavoriteDetailViewController: UIViewController {

    // MARK: - Properties

    var state: TranslationViewController.State {
        get { return translationViewController.state }
        set { translationViewController.state = newValue }
    }

    fileprivate var viewModel: TranslationViewModel?

    fileprivate weak var delegate: FavoriteDetailViewControllerDelegate?

    fileprivate let translationViewController: TranslationViewController = {
        let viewController = TranslationViewController()
        return viewController
    }()


    // MARK: - Init

    init(delegate: FavoriteDetailViewControllerDelegate) {
        self.delegate = delegate
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()

        addChildViewController(translationViewController)
        translationViewController.didMove(toParentViewController: self)

        view.addSubview(translationViewController.view)

        translationViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        translationViewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        translationViewController.view.topAnchor.constraint(equalTo: topLayoutGuide.topAnchor).isActive = true
        translationViewController.view.bottomAnchor.constraint(equalTo: bottomLayoutGuide.topAnchor).isActive = true
    }
}


extension FavoriteDetailViewController: FavoriteDetailViewControllerDelegate {

}
