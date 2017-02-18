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
    func searchViewController(_ searchViewController: SearchViewController, didSearchWord word: String, fromLanguage: Language, toLanguage: Language)
}

final class SearchViewController: UIViewController {

    // MARK: - Properties

    var state: TranslationViewController.State {
        get { return translationViewController.state }
        set { translationViewController.state = newValue }
    }

    fileprivate var viewModel: TranslationViewModel?

    fileprivate weak var delegate: SearchViewControllerDelegate?

    fileprivate let searchHeaderViewController: SearchHeaderViewController = {
        let viewController = SearchHeaderViewController()
        return viewController
    }()

    fileprivate let translationViewController: TranslationViewController = {
        let viewController = TranslationViewController()
        return viewController
    }()

    fileprivate let bodyView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.isOpaque = true
        stackView.layoutMargins = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
        stackView.isLayoutMarginsRelativeArrangement = true
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

        edgesForExtendedLayout = UIRectEdge()
        view.backgroundColor = Color.brand

        addChildViewController(searchHeaderViewController)
        searchHeaderViewController.didMove(toParentViewController: self)
        searchHeaderViewController.delegate = self

        addChildViewController(translationViewController)
        translationViewController.didMove(toParentViewController: self)
        translationViewController.delegate = self

        bodyView.addArrangedSubview(searchHeaderViewController.view)
        bodyView.addArrangedSubview(translationViewController.view)
        view.addSubview(bodyView)

        bodyView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        bodyView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        bodyView.topAnchor.constraint(equalTo: topLayoutGuide.topAnchor).isActive = true
        bodyView.bottomAnchor.constraint(equalTo: bottomLayoutGuide.topAnchor).isActive = true
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
}


extension SearchViewController: SearchHeaderViewControllerDelegate {
    func searchHeaderViewController(_ searchHeaderViewController: SearchHeaderViewController, didSearchWord word: String, fromLanguage: Language, toLanguage: Language) {
        state = .loading
        delegate?.searchViewController(self, didSearchWord: word, fromLanguage: fromLanguage, toLanguage: toLanguage)
    }

    func searchHeaderViewControllerDidResetSearch(_ searchHeaderViewController: SearchHeaderViewController) {
        state = .default
    }
}


extension SearchViewController: TranslationViewControllerDelegate {
    func translationViewControllerBecomeFirstResponder(_ translationViewController: TranslationViewController) {
        searchHeaderViewController.resignFirstResponder()
    }
}
