//
//  TranslationViewController.swift
//  weTranslate
//
//  Created by Lionel on 3/13/16.
//  Copyright © 2016 weTranslate. All rights reserved.
//

import UIKit

protocol TranslationViewControllerDelegate: class {
    func translationViewControllerBecomeFirstResponder(translationViewController: TranslationViewController)
}

final class TranslationViewController: UIViewController {

    // MARK: - Type

    enum State {
        case Default
        case Loading
        case Result(TranslationViewModel)
        case NoResult(NoResultViewModel)
        case Error
    }


    // MARK: - Properties

    var state: State = .Default {
        didSet {
            switch state {
            case .Default:
                noResultView.hidden = true
                tableView.hidden = false
                viewModel = nil
            case .Loading:
                noResultView.hidden = true
                tableView.hidden = false
            case .Result(let translationViewModel):
                noResultView.hidden = true
                tableView.hidden = false
                viewModel = translationViewModel
            case .NoResult(let noResultViewModel):
                noResultView.hidden = false
                tableView.hidden = true
                noResultView.viewModel = noResultViewModel
            case .Error:
                noResultView.hidden = false
                tableView.hidden = true
            }
            tableView.reloadData()
        }
    }

    weak var delegate: TranslationViewControllerDelegate?

    private var viewModel: TranslationViewModel?

    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.estimatedRowHeight = 70
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.separatorStyle = .None
        return tableView
    }()

    private let translationView: TranslationView = {
        let translationView = TranslationView(frame: .zero)
        translationView.translatesAutoresizingMaskIntoConstraints = false
        return translationView
    }()

    private let noResultView: NoResultView = {
        let view = NoResultView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.hidden = true
        return view
    }()

    private let bodyView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .Vertical
        stackView.opaque = true
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

        tableView.registerClass(WordTableViewCell.self, forCellReuseIdentifier: WordTableViewCell.cellIdentifier)
        tableView.registerClass(TableViewCell.self, forCellReuseIdentifier: TableViewCell.cellIdentifier)
        tableView.registerClass(LoadingTableViewCell.self, forCellReuseIdentifier: LoadingTableViewCell.cellIdentifier)
        tableView.delegate = self
        tableView.dataSource = self

        bodyView.addArrangedSubview(noResultView)
        bodyView.addArrangedSubview(tableView)
        view.addSubview(bodyView)

        bodyView.leadingAnchor.constraintEqualToAnchor(view.leadingAnchor).active = true
        bodyView.trailingAnchor.constraintEqualToAnchor(view.trailingAnchor).active = true
        bodyView.topAnchor.constraintEqualToAnchor(topLayoutGuide.bottomAnchor).active = true
        bodyView.bottomAnchor.constraintEqualToAnchor(bottomLayoutGuide.topAnchor).active = true
    }
}


extension TranslationViewController: UITableViewDataSource {

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard case .Result(let translationViewModel) = state else { return 1 }

        return translationViewModel.translation.meanings.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        if case .Loading = state,
            let cell = tableView.dequeueReusableCellWithIdentifier(LoadingTableViewCell.cellIdentifier, forIndexPath: indexPath) as? LoadingTableViewCell {
            cell.activityIndicator.startAnimating()
            return cell
        }

        guard case .Result(let translationViewModel) = state else { return UITableViewCell() }

        let wordViewModel = WordViewModel(word: translationViewModel.translation.meanings[indexPath.row].translatedWords[0])

        if indexPath.row == 0  && indexPath.section == 0 {
            translationView.viewModel = wordViewModel
            return TableViewCell(reuseIdentifier: "TranslationTableViewCell", view: translationView)

        } else if let cell = tableView.dequeueReusableCellWithIdentifier(WordTableViewCell.cellIdentifier, forIndexPath: indexPath) as? WordTableViewCell {
            cell.viewModel = wordViewModel
            return cell
        }

        return UITableViewCell()
    }
}


extension TranslationViewController: UITableViewDelegate {
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        // FIXME: Push to detail
    }
}


extension TranslationViewController: UIScrollViewDelegate {
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        delegate?.translationViewControllerBecomeFirstResponder(self)
    }
}
