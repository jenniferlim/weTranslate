//
//  SearchView.swift
//  weTranslate
//
//  Created by Lionel on 2/20/16.
//  Copyright © 2016 weTranslate. All rights reserved.
//

import UIKit

final class SearchHeaderView: UIView {

    // MARK: - Properties

    let searchTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = localize("SEARCH_TYPE_HERE")
        textField.textAlignment = .center
        textField.backgroundColor = .white
        textField.borderStyle = UITextBorderStyle.roundedRect
        textField.enablesReturnKeyAutomatically = true
        textField.autocorrectionType = .no
        textField.spellCheckingType = .no
        textField.returnKeyType = .search
        textField.clearButtonMode = .whileEditing
        return textField
    }()

    let fromLanguageButton: Button = {
        let button = Button(title: "English", color: .white)
        return button
    }()

    let toLanguageButton: Button = {
        let button = Button(title: "French", color: .white)
        return button
    }()

    let swapButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "Swap"), for: UIControlState())
        return button
    }()

    let languagesPickerView: UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        pickerView.isHidden = true
        pickerView.alpha = 0
        return pickerView
    }()

    fileprivate let languageView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 10
        return stackView
    }()

    fileprivate let bodyView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 25
        stackView.layoutMargins = UIEdgeInsets(top: 25, left: 25, bottom: 25, right: 25)
        stackView.isLayoutMarginsRelativeArrangement = true
        return stackView
    }()


    // MARK: - Initializers

    override init(frame: CGRect = .zero) {
        super.init(frame: frame)

        languageView.addArrangedSubview(fromLanguageButton)
        languageView.addArrangedSubview(swapButton)
        languageView.addArrangedSubview(toLanguageButton)

        bodyView.addArrangedSubview(searchTextField)
        bodyView.addArrangedSubview(languageView)
        bodyView.addArrangedSubview(languagesPickerView)
        addSubview(bodyView)

        let margins = layoutMarginsGuide
        bodyView.leadingAnchor.constraint(equalTo: margins.leadingAnchor).isActive = true
        bodyView.trailingAnchor.constraint(equalTo: margins.trailingAnchor).isActive = true
        bodyView.topAnchor.constraint(equalTo: margins.topAnchor).isActive = true
        bodyView.bottomAnchor.constraint(equalTo: margins.bottomAnchor).isActive = true

        searchTextField.heightAnchor.constraint(equalToConstant: 44).isActive = true
        fromLanguageButton.heightAnchor.constraint(equalToConstant: 25).isActive = true
        fromLanguageButton.widthAnchor.constraint(equalTo: toLanguageButton.widthAnchor, multiplier: 1.0).isActive = true
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
