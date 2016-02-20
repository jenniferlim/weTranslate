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
        searchBar.delegate = self

        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerClass(WordTableViewCell.self, forCellReuseIdentifier: WordTableViewCell.cellIdentifier)

        let margins = view.layoutMarginsGuide
        tableView.leadingAnchor.constraintEqualToAnchor(margins.leadingAnchor).active = true
        tableView.trailingAnchor.constraintEqualToAnchor(margins.trailingAnchor).active = true
        tableView.topAnchor.constraintEqualToAnchor(margins.topAnchor).active = true
        tableView.bottomAnchor.constraintEqualToAnchor(margins.bottomAnchor).active = true
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
    
    internal func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        // FIX ME: Push to detail
    }
}

extension SearchViewController: UISearchBarDelegate {
    
    internal func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        if let searchTerm = searchBar.text {
            self.delegate?.searchViewController(self, didSearchWord: searchTerm)
        }
    }
}
