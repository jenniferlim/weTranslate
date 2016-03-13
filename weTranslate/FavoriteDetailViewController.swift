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

    private var viewModel: TranslationViewModel?

    private weak var delegate: FavoriteDetailViewControllerDelegate?

    private let translationViewController: TranslationViewController = {
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
        translationViewController.didMoveToParentViewController(self)

        view.addSubview(translationViewController.view)

        translationViewController.view.leadingAnchor.constraintEqualToAnchor(view.leadingAnchor).active = true
        translationViewController.view.trailingAnchor.constraintEqualToAnchor(view.trailingAnchor).active = true
        translationViewController.view.topAnchor.constraintEqualToAnchor(topLayoutGuide.topAnchor).active = true
        translationViewController.view.bottomAnchor.constraintEqualToAnchor(bottomLayoutGuide.topAnchor).active = true
    }
}


extension FavoriteDetailViewController: FavoriteDetailViewControllerDelegate {

}
