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
    func searchViewController(searchViewController: SearchViewController, didSearchWord word: String)
}

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

    private let searchHeaderViewController: SearchHeaderViewController = {
        let searchHeaderViewController = SearchHeaderViewController()
        return searchHeaderViewController
    }()

    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.estimatedRowHeight = 70
        tableView.rowHeight = UITableViewAutomaticDimension
        return tableView
    }()

    private let translationView: TranslationView = {
        let translationView = TranslationView(frame: .zero)
        translationView.translatesAutoresizingMaskIntoConstraints = false
        return translationView
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

        addChildViewController(searchHeaderViewController)
        searchHeaderViewController.didMoveToParentViewController(self)
        searchHeaderViewController.delegate = self

        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerClass(WordTableViewCell.self, forCellReuseIdentifier: WordTableViewCell.cellIdentifier)
        tableView.registerClass(TableViewCell.self, forCellReuseIdentifier: TableViewCell.cellIdentifier)

        bodyView.addArrangedSubview(searchHeaderViewController.view)
        bodyView.addArrangedSubview(tableView)
        view.addSubview(bodyView)

        bodyView.leadingAnchor.constraintEqualToAnchor(view.leadingAnchor).active = true
        bodyView.trailingAnchor.constraintEqualToAnchor(view.trailingAnchor).active = true
        bodyView.topAnchor.constraintEqualToAnchor(view.topAnchor).active = true
        bodyView.bottomAnchor.constraintEqualToAnchor(view.bottomAnchor).active = true
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBarHidden = true
        
        delegate?.searchViewController(self, didSearchWord: "Arm")
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
        
        guard let searchViewModel = self.viewModel else { return UITableViewCell() }
        
        let wordViewModel = WordViewModel(word: searchViewModel.translation.meanings[indexPath.section].translatedWords[indexPath.row])
        
        if indexPath.row == 0  && indexPath.section == 0 {
            // Header cell
            translationView.viewModel = wordViewModel
            return TableViewCell(reuseIdentifier: "TranslationTableViewCell", view: translationView)
            
        } else if let cell = tableView.dequeueReusableCellWithIdentifier(WordTableViewCell.cellIdentifier, forIndexPath: indexPath) as? WordTableViewCell {
            cell.viewModel = wordViewModel
            return cell
        }
        
        return UITableViewCell()
    }
}

extension SearchViewController: UITableViewDelegate {
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        // FIXME: Push to detail
    }
}

extension SearchViewController: SearchHeaderViewControllerDelegate {
    func searchHeaderViewController(searchHeaderViewController: SearchHeaderViewController, didSearchWord word: String) {
        delegate?.searchViewController(self, didSearchWord: word)
    }
}
