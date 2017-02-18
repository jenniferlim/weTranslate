//
//  SearchHeaderViewController.swift
//  weTranslate
//
//  Created by Lionel on 2/21/16.
//  Copyright © 2016 weTranslate. All rights reserved.
//

import UIKit
import TranslateKit

protocol SearchHeaderViewControllerDelegate: class {
    func searchHeaderViewController(_ searchHeaderViewController: SearchHeaderViewController, didSearchWord word: String, fromLanguage: Language, toLanguage: Language)
    func searchHeaderViewControllerDidResetSearch(_ searchHeaderViewController: SearchHeaderViewController)
}

final class SearchHeaderViewController: UIViewController {

    // MARK: - Type

    fileprivate enum State {
        case `default`
        case keyboard
        case picker
    }


    // MARK: - Properties

    weak var delegate: SearchHeaderViewControllerDelegate?

    var viewModel = SearchHeaderViewModel() {
        didSet {
            searchHeaderView.fromLanguageButton.setTitle(viewModel.fromLanguage.name(), for: .normal)
            searchHeaderView.toLanguageButton.setTitle(viewModel.toLanguage.name(), for: .normal)
            searchHeaderView.languagesPickerView.reloadAllComponents()
            searchHeaderView.languagesPickerView.selectRow(viewModel.selectedRow, inComponent: viewModel.translateFromEnglish ? 1 : 0, animated: false)
            delegate?.searchHeaderViewControllerDidResetSearch(self)
        }
    }

    fileprivate let searchHeaderView: SearchHeaderView = {
        let view = SearchHeaderView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    fileprivate var state: State = .default {
        didSet {
            switch state {
            case .default where oldValue == .keyboard:
                searchHeaderView.searchTextField.resignFirstResponder()
                search()
            case .default where oldValue == .picker:
                toggle(expanded: false) { _ in self.search() }
            case .keyboard where oldValue == .picker:
                toggle(expanded: false)
            case .picker where oldValue != .picker:
                if oldValue == .keyboard {
                    searchHeaderView.searchTextField.resignFirstResponder()
                }
                toggle(expanded: true)
            default:
                break
            }
        }
    }


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

        searchHeaderView.searchTextField.delegate = self
        searchHeaderView.languagesPickerView.delegate = self
        searchHeaderView.fromLanguageButton.addTarget(self, action: #selector(SearchHeaderViewController.selectLanguage(_:)), for: .touchUpInside)
        searchHeaderView.toLanguageButton.addTarget(self, action: #selector(SearchHeaderViewController.selectLanguage(_:)), for: .touchUpInside)
        searchHeaderView.swapButton.addTarget(self, action: #selector(SearchHeaderViewController.swap(_:)), for: .touchUpInside)

        view.addSubview(searchHeaderView)

        searchHeaderView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        searchHeaderView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        searchHeaderView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        searchHeaderView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true

        viewModel = SearchHeaderViewModel()
    }


    // MARK: - UIResponder

    override func resignFirstResponder() -> Bool {
        state = .default
        return true
    }


    // MARK: - Methods

    func swap(_ sender: UIButton?) {
        viewModel.swap()
        search()
    }

    func selectLanguage(_ sender: UIButton?) {
        state = state == .picker ? .default : .picker
    }


    // MARK: - Private

    fileprivate func toggle(expanded: Bool, completion: ((Bool) -> Void)? = nil) {
        self.searchHeaderView.languagesPickerView.alpha = expanded ? 1 : 0
        animate(completion: completion) {
            self.searchHeaderView.languagesPickerView.isHidden = !expanded
        }
    }

    fileprivate func search() {
        if let word = searchHeaderView.searchTextField.text, word != "" {
            delegate?.searchHeaderViewController(self, didSearchWord: word, fromLanguage: viewModel.fromLanguage, toLanguage: viewModel.toLanguage)
        }
    }
}


extension SearchHeaderViewController: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        state = .default
        return true
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        state = .keyboard
    }
}


extension SearchHeaderViewController: UIPickerViewDataSource {

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch (component, viewModel.translateFromEnglish) {
        case (0, false), (1, true):
            return viewModel.languages.count
        default:
            return 1
        }
    }
}


extension SearchHeaderViewController: UIPickerViewDelegate {

    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let name = viewModel.languages[row].name()
        switch (component, viewModel.translateFromEnglish) {
        case (0, false), (1, true):
            return name.attributedString(withColor: UIColor.white)
        default:
            return name.attributedString(withColor: UIColor.white)
        }
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        viewModel.selectedLanguage = viewModel.languages[row]
    }
}
