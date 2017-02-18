//
//  TranslationViewController.swift
//  weTranslate
//
//  Created by Lionel on 3/13/16.
//  Copyright © 2016 weTranslate. All rights reserved.
//

import UIKit

protocol TranslationViewControllerDelegate: class {
    func translationViewControllerBecomeFirstResponder(_ translationViewController: TranslationViewController)
}

final class TranslationViewController: UIViewController {

    // MARK: - Type

    enum State {
        case `default`
        case loading
        case result(TranslationViewModel)
        case noResult(NoResultViewModel)
        case error
    }


    // MARK: - Properties

    var state: State = .default {
        didSet {
            switch state {
            case .default:
                noResultView.isHidden = true
                tableView.isHidden = false
                viewModel = nil
            case .loading:
                noResultView.isHidden = true
                tableView.isHidden = false
            case .result(let translationViewModel):
                noResultView.isHidden = true
                tableView.isHidden = false
                viewModel = translationViewModel
            case .noResult(let noResultViewModel):
                noResultView.isHidden = false
                tableView.isHidden = true
                noResultView.viewModel = noResultViewModel
            case .error:
                noResultView.isHidden = false
                tableView.isHidden = true
            }
            tableView.reloadData()
        }
    }

    weak var delegate: TranslationViewControllerDelegate?

    fileprivate var viewModel: TranslationViewModel?

    fileprivate let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.estimatedRowHeight = 70
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.separatorStyle = .none
        return tableView
    }()

    fileprivate let translationView: TranslationView = {
        let translationView = TranslationView(frame: .zero)
        translationView.translatesAutoresizingMaskIntoConstraints = false
        return translationView
    }()

    fileprivate let noResultView: NoResultView = {
        let view = NoResultView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isHidden = true
        return view
    }()

    fileprivate let bodyView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.isOpaque = true
        return stackView
    }()


    // MARK: - Init

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(WordTableViewCell.self, forCellReuseIdentifier: WordTableViewCell.cellIdentifier)
        tableView.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.cellIdentifier)
        tableView.register(LoadingTableViewCell.self, forCellReuseIdentifier: LoadingTableViewCell.cellIdentifier)
        tableView.delegate = self
        tableView.dataSource = self

        bodyView.addArrangedSubview(noResultView)
        bodyView.addArrangedSubview(tableView)
        view.addSubview(bodyView)

        bodyView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        bodyView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        bodyView.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor).isActive = true
        bodyView.bottomAnchor.constraint(equalTo: bottomLayoutGuide.topAnchor).isActive = true
    }
}


extension TranslationViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard case .result(let translationViewModel) = state else { return 1 }

        return translationViewModel.translation.meanings.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if case .loading = state,
            let cell = tableView.dequeueReusableCell(withIdentifier: LoadingTableViewCell.cellIdentifier, for: indexPath) as? LoadingTableViewCell {
            cell.activityIndicator.startAnimating()
            return cell
        }

        guard case .result(let translationViewModel) = state else { return UITableViewCell() }

        let meaning = translationViewModel.translation.meanings[indexPath.row]
        let word = meaning.translatedWords[0]
        let wordViewModel = WordViewModel(word: word, originalWord: meaning.originalWord)

        if indexPath.row == 0  && indexPath.section == 0 {
            translationView.viewModel = wordViewModel
            return TableViewCell(reuseIdentifier: "TranslationTableViewCell", view: translationView)

        } else if let cell = tableView.dequeueReusableCell(withIdentifier: WordTableViewCell.cellIdentifier, for: indexPath) as? WordTableViewCell {
            cell.viewModel = wordViewModel
            return cell
        }

        return UITableViewCell()
    }
}


extension TranslationViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // FIXME: Push to detail
    }
}


extension TranslationViewController: UIScrollViewDelegate {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        delegate?.translationViewControllerBecomeFirstResponder(self)
    }
}
