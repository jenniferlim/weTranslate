//
//  SearchView.swift
//  weTranslate
//
//  Created by Lionel on 2/20/16.
//  Copyright © 2016 weTranslate. All rights reserved.
//

import UIKit

final class SearchView: UIView {

    // MARK: - Properties

    private let searchTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Type here..."
        textField.textAlignment = .Center
        textField.backgroundColor = UIColor.whiteColor()
        textField.borderStyle = UITextBorderStyle.RoundedRect
        return textField
    }()

    private let fromLanguageButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("English", forState: .Normal)
        button.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        return button
    }()

    private let toLanguageButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("French", forState: .Normal)
        button.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        return button
    }()

    private let swapButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "Swap"), forState: .Normal)
        return button
    }()

    private let languageView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .Horizontal
        stackView.spacing = 10
        return stackView
    }()

    private let bodyView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .Vertical
        stackView.spacing = 25
        stackView.layoutMargins = UIEdgeInsets(top: 25, left: 25, bottom: 25, right: 25)
        stackView.layoutMarginsRelativeArrangement = true
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

        addSubview(bodyView)

        let margins = layoutMarginsGuide
        bodyView.leadingAnchor.constraintEqualToAnchor(margins.leadingAnchor).active = true
        bodyView.trailingAnchor.constraintEqualToAnchor(margins.trailingAnchor).active = true
        bodyView.topAnchor.constraintEqualToAnchor(margins.topAnchor).active = true
        bodyView.bottomAnchor.constraintEqualToAnchor(margins.bottomAnchor).active = true

        searchTextField.heightAnchor.constraintEqualToConstant(44).active = true
        fromLanguageButton.heightAnchor.constraintEqualToConstant(25).active = true
        fromLanguageButton.widthAnchor.constraintEqualToAnchor(toLanguageButton.widthAnchor, multiplier: 1.0).active = true
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
