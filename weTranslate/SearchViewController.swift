//
//  SearchViewController.swift
//  weTranslate
//
//  Created by Lionel on 2/14/16.
//  Copyright © 2016 weTranslate. All rights reserved.
//

import UIKit
import TranslateKit

protocol SearchViewControllerDelegate: class {
    func searchViewController(searchViewController: SearchViewController, didSearchWord word: String, fromLanguage: Language, toLanguage: Language)
}

final class SearchViewController: UIViewController {

    // MARK: - Properties

    var state: TranslationViewController.State {
        get { return translationViewController.state }
        set { translationViewController.state = newValue }
    }

    private var viewModel: TranslationViewModel?

    private weak var delegate: SearchViewControllerDelegate?

    private let searchHeaderViewController: SearchHeaderViewController = {
        let viewController = SearchHeaderViewController()
        return viewController
    }()

    private let translationViewController: TranslationViewController = {
        let viewController = TranslationViewController()
        return viewController
    }()

    private let bodyView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .Vertical
        stackView.opaque = true
        stackView.layoutMargins = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
        stackView.layoutMarginsRelativeArrangement = true
        return stackView
    }()


    // MARK: - Init

    init(delegate: SearchViewControllerDelegate) {
        self.delegate = delegate
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()

        edgesForExtendedLayout = .None
        view.backgroundColor = Color.brand

        addChildViewController(searchHeaderViewController)
        searchHeaderViewController.didMoveToParentViewController(self)
        searchHeaderViewController.delegate = self

        addChildViewController(translationViewController)
        translationViewController.didMoveToParentViewController(self)
        translationViewController.delegate = self

        bodyView.addArrangedSubview(searchHeaderViewController.view)
        bodyView.addArrangedSubview(translationViewController.view)
        view.addSubview(bodyView)

        bodyView.leadingAnchor.constraintEqualToAnchor(view.leadingAnchor).active = true
        bodyView.trailingAnchor.constraintEqualToAnchor(view.trailingAnchor).active = true
        bodyView.topAnchor.constraintEqualToAnchor(topLayoutGuide.topAnchor).active = true
        bodyView.bottomAnchor.constraintEqualToAnchor(bottomLayoutGuide.topAnchor).active = true
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBarHidden = true
    }

    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBarHidden = false
    }
}


extension SearchViewController: SearchHeaderViewControllerDelegate {
    func searchHeaderViewController(searchHeaderViewController: SearchHeaderViewController, didSearchWord word: String, fromLanguage: Language, toLanguage: Language) {
        state = .Loading
        delegate?.searchViewController(self, didSearchWord: word, fromLanguage: fromLanguage, toLanguage: toLanguage)
    }

    func searchHeaderViewControllerDidResetSearch(searchHeaderViewController: SearchHeaderViewController) {
        state = .Default
    }
}


extension SearchViewController: TranslationViewControllerDelegate {
    func translationViewControllerBecomeFirstResponder(translationViewController: TranslationViewController) {
        searchHeaderViewController.resignFirstResponder()
    }
}
