//
//  TranslationView.swift
//  weTranslate
//
//  Created by Jennifer on 21/02/2016.
//  Copyright © 2016 weTranslate. All rights reserved.
//

import UIKit

final class TranslationView: UIView {

    // MARK: - Properties

    var viewModel: WordViewModel? {
        didSet {
            if let viewModel = viewModel {
                wordLabel.text = viewModel.word.capitalizedString
                senseLabel.text = "(\(viewModel.sense))"
            }
        }
    }

    private let wordLabel: Label = {
        let label = Label(textColor: Color.brand, font: Font.font(style: .Title1))
        label.numberOfLines = 0
        label.textAlignment = NSTextAlignment.Center
        return label
    }()

    private let senseLabel: Label = {
        let label = Label(textColor: Color.brand, font: Font.font(style: .Caption2))
        label.numberOfLines = 0
        label.textAlignment = NSTextAlignment.Center
        return label
    }()

    private let bodyView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .Vertical
        stackView.spacing = 10
        stackView.layoutMargins = UIEdgeInsets(top: 25, left: 25, bottom: 25, right: 25)
        stackView.layoutMarginsRelativeArrangement = true
        return stackView
    }()


    // MARK: - Init

    override init(frame: CGRect = .zero) {

        super.init(frame: frame)

        backgroundColor = Color.background
        opaque = true
        layer.borderColor = Color.brand.CGColor
        layer.borderWidth = 1

        bodyView.addArrangedSubview(wordLabel)
        bodyView.addArrangedSubview(senseLabel)
        addSubview(bodyView)

        let margins = layoutMarginsGuide
        bodyView.leadingAnchor.constraintEqualToAnchor(margins.leadingAnchor).active = true
        bodyView.trailingAnchor.constraintEqualToAnchor(margins.trailingAnchor).active = true
        bodyView.topAnchor.constraintEqualToAnchor(margins.topAnchor).active = true
        bodyView.bottomAnchor.constraintEqualToAnchor(margins.bottomAnchor).active = true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
