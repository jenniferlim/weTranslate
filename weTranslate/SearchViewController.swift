//
//  SearchViewController.swift
//  weTranslate
//
//  Created by Lionel on 2/14/16.
//  Copyright © 2016 weTranslate. All rights reserved.
//

import UIKit
import TranslateKit

final class SearchViewController: UIViewController {

    // MARK: - Properties

    var viewModel: SearchViewModel? {
        didSet {
            dispatch_async(dispatch_get_main_queue()) { [weak self] () -> Void in
                self?.tableView.reloadData()
            }
        }
    }

    private weak var delegate: SearchViewControllerDelegate?

    private let searchView: SearchView = {
        let view = SearchView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.registerClass(WordTableViewCell.self, forCellReuseIdentifier: WordTableViewCell.cellIdentifier)
        return tableView
    }()

    private let bodyView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .Vertical
        stackView.spacing = 5
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

        view.backgroundColor = Color.brand

        bodyView.addArrangedSubview(searchView)
        bodyView.addArrangedSubview(tableView)
        view.addSubview(bodyView)

        tableView.delegate = self
        tableView.dataSource = self

        bodyView.leadingAnchor.constraintEqualToAnchor(view.leadingAnchor).active = true
        bodyView.trailingAnchor.constraintEqualToAnchor(view.trailingAnchor).active = true
        bodyView.topAnchor.constraintEqualToAnchor(view.topAnchor).active = true
        bodyView.bottomAnchor.constraintEqualToAnchor(view.bottomAnchor).active = true
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

extension SearchViewController: UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        guard let searchViewModel = self.viewModel else { return 0 }
        
        return searchViewModel.translation.meanings.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let searchViewModel = self.viewModel else { return 0 }
        
        return searchViewModel.translation.meanings[section].translatedWords.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        guard let searchViewModel = self.viewModel,
            cell = tableView.dequeueReusableCellWithIdentifier(WordTableViewCell.cellIdentifier, forIndexPath: indexPath) as? WordTableViewCell
            else { return UITableViewCell() }
        
        let wordViewModel = WordViewModel(word: searchViewModel.translation.meanings[indexPath.section].translatedWords[indexPath.row])
        
        cell.viewModel = wordViewModel
        
        return cell
    }
}

extension SearchViewController: UITableViewDelegate {
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        // FIXME: Push to detail
    }
}

extension SearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        if let searchTerm = searchBar.text {
            self.delegate?.searchViewController(self, didSearchWord: searchTerm)
        }
    }
}
