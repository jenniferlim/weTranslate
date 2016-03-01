//
//  NoResultTableViewCell.swift
//  weTranslate
//
//  Created by Lionel on 2/28/16.
//  Copyright © 2016 weTranslate. All rights reserved.
//

import UIKit

final class NoResultView: UIView {

    // MARK: - Properties

    var viewModel: NoResultViewModel? {
        didSet {
            noResultLabel.text = viewModel?.message
            emojiLabel.text = viewModel?.emoji
        }
    }

    let noResultLabel: Label = {
        let label = Label(font: Font.font(style: .Title3))
        label.numberOfLines = 0
        label.textAlignment = NSTextAlignment.Center
        return label
    }()

    let emojiLabel: Label = {
        let label = Label(font: Font.emojiFont())
        label.textAlignment = NSTextAlignment.Center
        return label
    }()

    let translateItLabel: Label = {
        let label = Label(textColor: Color.standardText, font: Font.font(style: .Body))
        label.numberOfLines = 0
        label.textAlignment = NSTextAlignment.Center
        label.text = localize("TRANSLATE_IT_FIRST")
        return label
    }()

    let translateItButton: Button = {
        let button = Button(title: localize("TRANSLATE_IT"), color: Color.invertedBrand)
        return button
    }()

    private let bodyView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .Vertical
        stackView.spacing = 25
        stackView.layoutMargins = UIEdgeInsets(top: 30, left: 40, bottom: 30, right: 40)
        stackView.layoutMarginsRelativeArrangement = true
        return stackView
    }()


    // MARK: - Initializer

    override init(frame: CGRect) {
        super.init(frame: .zero)

        backgroundColor = Color.background
        opaque = true

        bodyView.addArrangedSubview(noResultLabel)
        bodyView.addArrangedSubview(emojiLabel)
        bodyView.addArrangedSubview(translateItLabel)
        bodyView.addArrangedSubview(translateItButton)
        addSubview(bodyView)

        let margins = layoutMarginsGuide
        bodyView.leadingAnchor.constraintEqualToAnchor(margins.leadingAnchor).active = true
        bodyView.trailingAnchor.constraintEqualToAnchor(margins.trailingAnchor).active = true
        bodyView.topAnchor.constraintEqualToAnchor(margins.topAnchor).active = true
        let bottomConstraint = bodyView.bottomAnchor.constraintEqualToAnchor(margins.bottomAnchor)
        bottomConstraint.priority = 250
        bottomConstraint.active = true

        let heightConstraint = translateItButton.heightAnchor.constraintEqualToConstant(50.0)
        heightConstraint.priority = 999
        heightConstraint.active = true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
