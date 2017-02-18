//
//  FavoritesViewController.swift
//  weTranslate
//
//  Created by Jennifer on 27/02/2016.
//  Copyright © 2016 weTranslate. All rights reserved.
//

import UIKit
import TranslateKit

protocol FavoriteCategoriesViewControllerDelegate: class {
    func favoriteCategoriesViewControllerNeedsUpdate(_ favoriteCategoriesViewController: FavoriteCategoriesViewController)
    func favoriteCategoriesViewController(_ favoriteCategoriesViewController: FavoriteCategoriesViewController, didSelectCategory category: FavoriteCategory)
}

final class FavoriteCategoriesViewController: UIViewController {

    // MARK: - Properties

    var viewModel: [FavoriteCategoryViewModel]? {
        didSet {
            DispatchQueue.main.async { [weak self] in self?.tableView.reloadData() }
        }
    }

    fileprivate weak var delegate: FavoriteCategoriesViewControllerDelegate?

    fileprivate let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.estimatedRowHeight = 250
        tableView.rowHeight = UITableViewAutomaticDimension
        return tableView
    }()

    fileprivate let favoriteCategoriesTableViewCell: FavoriteCategoriesTableViewCell = {
        let favoriteCategoriesTableViewCell = FavoriteCategoriesTableViewCell(frame: .zero)
        favoriteCategoriesTableViewCell.translatesAutoresizingMaskIntoConstraints = false
        return favoriteCategoriesTableViewCell
    }()

    fileprivate let bodyView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.isOpaque = true
        stackView.layoutMargins = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        stackView.isLayoutMarginsRelativeArrangement = true
        return stackView
    }()

    // MARK: - Initializer

    init(delegate: FavoriteCategoriesViewControllerDelegate) {
        self.delegate = delegate
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()

        title = localize("FAVORITES_TITLE")
        view.backgroundColor = Color.brand

        tableView.register(FavoriteCategoriesTableViewCell.self, forCellReuseIdentifier: FavoriteCategoriesTableViewCell.cellIdentifier)
        tableView.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.cellIdentifier)
        tableView.delegate = self
        tableView.dataSource = self

        bodyView.addArrangedSubview(tableView)
        view.addSubview(bodyView)

        bodyView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        bodyView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        bodyView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        bodyView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        delegate?.favoriteCategoriesViewControllerNeedsUpdate(self)
    }
}

extension FavoriteCategoriesViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        guard let favoriteCategoriesViewModel = self.viewModel else { return 0 }

        return favoriteCategoriesViewModel.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let favoriteCategoriesViewModel = self.viewModel,
            let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteCategoriesTableViewCell.cellIdentifier, for: indexPath) as? FavoriteCategoriesTableViewCell else { return UITableViewCell() }

        cell.viewModel = favoriteCategoriesViewModel[indexPath.row]

        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
}


extension FavoriteCategoriesViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let viewModel = viewModel {
            let favoriteCategory = viewModel[indexPath.row].favoriteCategory
            delegate?.favoriteCategoriesViewController(self, didSelectCategory: favoriteCategory)
        }
    }
}
