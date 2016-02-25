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
    func searchHeaderViewController(searchHeaderViewController: SearchHeaderViewController, didSearchWord word: String, fromLanguage: Language, toLanguage: Language)
}

final class SearchHeaderViewController: UIViewController {

    // MARK: - Type

    private enum State {
        case Default
        case Keyboard
        case Picker
    }


    // MARK: - Properties

    weak var delegate: SearchHeaderViewControllerDelegate?

    var viewModel = SearchHeaderViewModel() {
        didSet {
            searchHeaderView.fromLanguageButton.setTitle(viewModel.fromLanguage.name(), forState: .Normal)
            searchHeaderView.toLanguageButton.setTitle(viewModel.toLanguage.name(), forState: .Normal)
            searchHeaderView.languagesPickerView.selectRow(viewModel.selectedRow, inComponent: 0, animated: false)
        }
    }

    private let searchHeaderView: SearchHeaderView = {
        let view = SearchHeaderView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private var state: State = .Default {
        didSet {
            switch state {
            case .Default:
                searchHeaderView.searchTextField.resignFirstResponder()
                toggle(expended: false)
            case .Keyboard:
                toggle(expended: false)
            case .Picker:
                searchHeaderView.searchTextField.resignFirstResponder()
                toggle(expended: true)
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
        searchHeaderView.fromLanguageButton.addTarget(self, action: "selectLanguage:", forControlEvents: .TouchUpInside)
        searchHeaderView.toLanguageButton.addTarget(self, action: "selectLanguage:", forControlEvents: .TouchUpInside)
        searchHeaderView.swapButton.addTarget(self, action: "swap:", forControlEvents: .TouchUpInside)

        view.addSubview(searchHeaderView)

        searchHeaderView.leadingAnchor.constraintEqualToAnchor(view.leadingAnchor).active = true
        searchHeaderView.trailingAnchor.constraintEqualToAnchor(view.trailingAnchor).active = true
        searchHeaderView.topAnchor.constraintEqualToAnchor(view.topAnchor).active = true
        searchHeaderView.bottomAnchor.constraintEqualToAnchor(view.bottomAnchor).active = true

        viewModel = SearchHeaderViewModel()
    }


    // MARK: - UIResponder

    override func resignFirstResponder() -> Bool {
        state = .Default
        return true
    }


    // MARK: - Methods

    func swap(sender: UIButton?) {
        viewModel.swap()
        search()
    }

    func selectLanguage(sender: UIButton?) {
        state = state == .Picker ? .Default : .Picker
    }


    // MARK: - Private

    private func toggle(expended expended: Bool) {
        self.searchHeaderView.languagesPickerView.alpha = expended ? 1 : 0
        animate {
            self.searchHeaderView.languagesPickerView.hidden = !expended
        }
    }

    private func search() {
        if let word = searchHeaderView.searchTextField.text {
            delegate?.searchHeaderViewController(self, didSearchWord: word, fromLanguage: viewModel.fromLanguage, toLanguage: viewModel.toLanguage)
            state = .Default
        }
    }
}


extension SearchHeaderViewController: UITextFieldDelegate {

    func textFieldShouldReturn(textField: UITextField) -> Bool {
        search()
        return true
    }

    func textFieldDidBeginEditing(textField: UITextField) {
        state = .Keyboard
    }
}


extension SearchHeaderViewController: UIPickerViewDataSource {

    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return viewModel.languages.count
    }
}


extension SearchHeaderViewController: UIPickerViewDelegate {

    func pickerView(pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let attributes = [NSForegroundColorAttributeName : UIColor.whiteColor()]
        return NSAttributedString(string: viewModel.languages[row].name(), attributes: attributes)
    }

    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        viewModel.selectedLanguage = viewModel.languages[row]
        search()
    }
}
