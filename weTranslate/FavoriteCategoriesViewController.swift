//
//  FavoritesViewController.swift
//  weTranslate
//
//  Created by Jennifer on 27/02/2016.
//  Copyright © 2016 weTranslate. All rights reserved.
//

import UIKit
import TranslateKit

final class FavoriteCategoriesViewController: UIViewController {

    // MARK: - Properties

    var viewModel: [FavoriteCategoryViewModel]? {
        didSet {
            dispatch_async(dispatch_get_main_queue()) { [weak self] () -> Void in
                self?.tableView.reloadData()
            }
        }
    }

    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.estimatedRowHeight = 250
        tableView.rowHeight = UITableViewAutomaticDimension
        return tableView
    }()

    private let favoriteCategoriesTableViewCell: FavoriteCategoriesTableViewCell = {
        let favoriteCategoriesTableViewCell = FavoriteCategoriesTableViewCell(frame: .zero)
        favoriteCategoriesTableViewCell.translatesAutoresizingMaskIntoConstraints = false
        return favoriteCategoriesTableViewCell
    }()

    private let bodyView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .Vertical
        stackView.spacing = 5
        stackView.opaque = true
        stackView.layoutMargins = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        stackView.layoutMarginsRelativeArrangement = true
        return stackView
    }()


    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = Color.brand

        tableView.registerClass(FavoriteCategoriesTableViewCell.self, forCellReuseIdentifier: FavoriteCategoriesTableViewCell.cellIdentifier)
        tableView.registerClass(TableViewCell.self, forCellReuseIdentifier: TableViewCell.cellIdentifier)
        tableView.delegate = self
        tableView.dataSource = self

        bodyView.addArrangedSubview(tableView)
        view.addSubview(bodyView)

        bodyView.leadingAnchor.constraintEqualToAnchor(view.leadingAnchor).active = true
        bodyView.trailingAnchor.constraintEqualToAnchor(view.trailingAnchor).active = true
        bodyView.topAnchor.constraintEqualToAnchor(view.topAnchor).active = true
        bodyView.bottomAnchor.constraintEqualToAnchor(view.bottomAnchor).active = true
    }
}

extension FavoriteCategoriesViewController: UITableViewDataSource {

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        guard let favoriteCategoriesViewModel = self.viewModel else { return 0 }

        return favoriteCategoriesViewModel.count
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        guard let favoriteCategoriesViewModel = self.viewModel,
            cell = tableView.dequeueReusableCellWithIdentifier(FavoriteCategoriesTableViewCell.cellIdentifier, forIndexPath: indexPath) as? FavoriteCategoriesTableViewCell else { return UITableViewCell() }

        cell.viewModel = favoriteCategoriesViewModel[indexPath.row]

        return cell
    }

    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 250
    }
}


extension FavoriteCategoriesViewController: UITableViewDelegate {

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        // FIXME: Push to detail
    }
}
