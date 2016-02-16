//
//  SearchViewController.swift
//  weTranslate
//
//  Created by Lionel on 2/14/16.
//  Copyright © 2016 weTranslate. All rights reserved.
//

import UIKit

final class SearchViewController: UIViewController {

    // MARK: - Properties

    var viewModel: SearchViewModel = SearchViewModel() {
        didSet {
            // FIXME: The view model just got updated, update the view
        }
    }

    private weak var delegate: SearchViewControllerDelegate?

    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar(frame: .zero)
        return searchBar
    }()

    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
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
        // Do any additional setup after loading the view, typically from a nib.

        view.backgroundColor = .whiteColor()
        view.addSubview(tableView)
        navigationItem.titleView = searchBar
        tableView.registerClass(WordTableViewCell.self, forCellReuseIdentifier: WordTableViewCell.cellIdentifier)

        let margins = view.layoutMarginsGuide
        tableView.leadingAnchor.constraintEqualToAnchor(margins.leadingAnchor).active = true
        tableView.trailingAnchor.constraintEqualToAnchor(margins.trailingAnchor).active = true
        tableView.topAnchor.constraintEqualToAnchor(margins.topAnchor).active = true
        tableView.bottomAnchor.constraintEqualToAnchor(margins.bottomAnchor).active = true
    }
}

// FIXME: implement UITableViewDataSource and UITableViewDelegate
//extension SearchViewController: UITableViewDataSource {
//
//}
//
//extension SearchViewController: UITableViewDelegate {
//
//}

// FIXME: implement UISearchDelegate
//extension SearchViewController: UISearchDelegate {
//
//}
