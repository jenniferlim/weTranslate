//
//  FavoriteViewController.swift
//  weTranslate
//
//  Created by Jennifer on 10/03/2016.
//  Copyright © 2016 weTranslate. All rights reserved.
//

import UIKit

final class FavoritesViewController: UIViewController {

    // MARK: - Properties

    var viewModels: [FavoriteViewModel]? {
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

    private let favoriteTableViewCell: FavoriteTableViewCell = {
        let favoriteTableViewCell = FavoriteTableViewCell(frame: .zero)
        favoriteTableViewCell.translatesAutoresizingMaskIntoConstraints = false
        return favoriteTableViewCell
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = Color.brand

        tableView.registerClass(FavoriteTableViewCell.self, forCellReuseIdentifier: FavoriteTableViewCell.cellIdentifier)
        tableView.dataSource = self

        view.addSubview(tableView)

        tableView.leadingAnchor.constraintEqualToAnchor(view.leadingAnchor).active = true
        tableView.trailingAnchor.constraintEqualToAnchor(view.trailingAnchor).active = true
        tableView.topAnchor.constraintEqualToAnchor(view.topAnchor).active = true
        tableView.bottomAnchor.constraintEqualToAnchor(view.bottomAnchor).active = true
    }
}

extension FavoritesViewController: UITableViewDataSource {

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        guard let _ = viewModels else { return 0 }

        return 1
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let favoriteViewModels = viewModels else { return 0 }

        return favoriteViewModels.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        guard let favoriteViewModels = viewModels else { return UITableViewCell() }

        if let cell = tableView.dequeueReusableCellWithIdentifier(FavoriteTableViewCell.cellIdentifier, forIndexPath: indexPath) as? FavoriteTableViewCell {
            cell.viewModel = favoriteViewModels[indexPath.row]
            return cell
        }

        return UITableViewCell()
    }
}
