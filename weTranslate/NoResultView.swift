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
        let label = Label(font: Font.font(.title3))
        label.numberOfLines = 0
        label.textAlignment = NSTextAlignment.center
        return label
    }()

    let emojiLabel: Label = {
        let label = Label(font: Font.hugeEmojiFont())
        label.textAlignment = NSTextAlignment.center
        return label
    }()

    let translateItLabel: Label = {
        let label = Label(textColor: Color.standardText, font: Font.font(.body))
        label.numberOfLines = 0
        label.textAlignment = NSTextAlignment.center
        label.text = localize("TRANSLATE_IT_FIRST")
        return label
    }()

    let translateItButton: Button = {
        let button = Button(title: localize("TRANSLATE_IT"), color: Color.invertedBrand)
        return button
    }()

    fileprivate let bodyView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 25
        stackView.layoutMargins = UIEdgeInsets(top: 30, left: 40, bottom: 30, right: 40)
        stackView.isLayoutMarginsRelativeArrangement = true
        return stackView
    }()


    // MARK: - Initializer

    override init(frame: CGRect) {
        super.init(frame: .zero)

        backgroundColor = Color.background
        isOpaque = true

        bodyView.addArrangedSubview(noResultLabel)
        bodyView.addArrangedSubview(emojiLabel)
        bodyView.addArrangedSubview(translateItLabel)
        bodyView.addArrangedSubview(translateItButton)
        addSubview(bodyView)

        let margins = layoutMarginsGuide
        bodyView.leadingAnchor.constraint(equalTo: margins.leadingAnchor).isActive = true
        bodyView.trailingAnchor.constraint(equalTo: margins.trailingAnchor).isActive = true
        bodyView.topAnchor.constraint(equalTo: margins.topAnchor).isActive = true
        let bottomConstraint = bodyView.bottomAnchor.constraint(equalTo: margins.bottomAnchor)
        bottomConstraint.priority = 250
        bottomConstraint.isActive = true

        let heightConstraint = translateItButton.heightAnchor.constraint(equalToConstant: 50.0)
        heightConstraint.priority = 999
        heightConstraint.isActive = true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
