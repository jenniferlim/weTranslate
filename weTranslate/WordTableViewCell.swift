//
//  TranslationTableViewCell.swift
//  weTranslate
//
//  Created by Lionel on 2/15/16.
//  Copyright © 2016 weTranslate. All rights reserved.
//

import UIKit

final class WordTableViewCell: UITableViewCell {

    // MARK: - Properties

    var viewModel: WordViewModel? {
        didSet {
            if let viewModel = viewModel {
                wordLabel.text = viewModel.word.capitalized
                senseLabel.text = "(\(viewModel.sense))"
            }
        }
    }

    fileprivate let wordLabel: Label = {
        let label = Label(textColor: Color.brand, font: Font.font())
        label.numberOfLines = 0
        return label
    }()

    fileprivate let senseLabel: Label = {
        let label = Label(textColor: Color.standardText, font: Font.font(style: .caption1))
        label.numberOfLines = 0
        return label
    }()

    fileprivate let columnView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .top
        stackView.spacing = 10
        return stackView
    }()

    fileprivate let bodyView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 5
        return stackView
    }()


    // MARK: - Init

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        contentView.isOpaque = true
        backgroundColor = .white
        isOpaque = true

        bodyView.addArrangedSubview(wordLabel)
        bodyView.addArrangedSubview(senseLabel)
        columnView.addArrangedSubview(bodyView)
        contentView.addSubview(columnView)

        let margins = contentView.layoutMarginsGuide
        columnView.leadingAnchor.constraint(equalTo: margins.leadingAnchor).isActive = true
        columnView.trailingAnchor.constraint(equalTo: margins.trailingAnchor).isActive = true
        columnView.topAnchor.constraint(equalTo: margins.topAnchor).isActive = true
        columnView.bottomAnchor.constraint(equalTo: margins.bottomAnchor).isActive = true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
