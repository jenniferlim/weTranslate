//
//  FavoriteViewController.swift
//  weTranslate
//
//  Created by Jennifer on 10/03/2016.
//  Copyright © 2016 weTranslate. All rights reserved.
//

import UIKit
import TranslateKit

protocol FavoritesViewControllerDelegate: class {
    func favoritesViewController(_ favoritesViewController: FavoritesViewController, didSelectTranslation translation: Translation)
}

final class FavoritesViewController: UIViewController {

    // MARK: - Properties

    var viewModels: [FavoriteViewModel]? {
        didSet {
            tableView.reloadData()
        }
    }

    fileprivate weak var delegate: FavoritesViewControllerDelegate?

    fileprivate let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.estimatedRowHeight = 200
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.backgroundColor = UIColor.groupTableViewBackground
        tableView.separatorStyle = .none
        return tableView
    }()


    // MARK: - Initializer

    init(delegate: FavoritesViewControllerDelegate) {
        self.delegate = delegate
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UINib.init(nibName: "FavoriteTableViewCell", bundle: nil), forCellReuseIdentifier: FavoriteTableViewCell.cellIdentifier)

        tableView.dataSource = self
        tableView.delegate = self

        view.addSubview(tableView)

        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}


extension FavoritesViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        guard let _ = viewModels else { return 0 }

        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let favoriteViewModels = viewModels else { return 0 }

        return favoriteViewModels.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let favoriteViewModels = viewModels else { return UITableViewCell() }

        if let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteTableViewCell.cellIdentifier, for: indexPath) as? FavoriteTableViewCell {
            cell.viewModel = favoriteViewModels[indexPath.row]
            return cell
        }

        return UITableViewCell()
    }
}


extension FavoritesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let favoriteViewModels = viewModels else { return }

        let translation = favoriteViewModels[indexPath.row].translation
        delegate?.favoritesViewController(self, didSelectTranslation: translation)
    }
}
