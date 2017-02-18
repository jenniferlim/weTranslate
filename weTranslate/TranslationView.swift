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
                wordLabel.text = viewModel.word.capitalized
                senseLabel.text = viewModel.sense
                senseLabel.hidden = viewModel.isSenseHidden
            }
        }
    }

    fileprivate let wordLabel: Label = {
        let label = Label(textColor: Color.brand, font: Font.font(style: .title1))
        label.numberOfLines = 0
        label.textAlignment = NSTextAlignment.center
        return label
    }()

    fileprivate let senseLabel: Label = {
        let label = Label(textColor: Color.brand, font: Font.font(style: .caption2))
        label.numberOfLines = 0
        label.textAlignment = NSTextAlignment.center
        return label
    }()

    fileprivate let bodyView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.layoutMargins = UIEdgeInsets(top: 25, left: 25, bottom: 25, right: 25)
        stackView.isLayoutMarginsRelativeArrangement = true
        return stackView
    }()


    // MARK: - Init

    override init(frame: CGRect = .zero) {

        super.init(frame: frame)

        backgroundColor = Color.background
        isOpaque = true
        layer.borderColor = Color.brand.cgColor
        layer.borderWidth = 1

        bodyView.addArrangedSubview(wordLabel)
        bodyView.addArrangedSubview(senseLabel)
        addSubview(bodyView)

        let margins = layoutMarginsGuide
        bodyView.leadingAnchor.constraint(equalTo: margins.leadingAnchor).isActive = true
        bodyView.trailingAnchor.constraint(equalTo: margins.trailingAnchor).isActive = true
        bodyView.topAnchor.constraint(equalTo: margins.topAnchor).isActive = true
        bodyView.bottomAnchor.constraint(equalTo: margins.bottomAnchor).isActive = true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
