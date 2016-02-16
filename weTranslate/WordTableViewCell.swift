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
                wordLabel.text = viewModel.word
                senseLabel.text = viewModel.sense
            }
        }
    }

    let wordLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()

    let senseLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()

    private let columnView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .Top
        stackView.spacing = 10
        return stackView
    }()

    private let bodyView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .Vertical
        stackView.spacing = 4
        return stackView
    }()



    // MARK: - Init

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        contentView.opaque = true
        backgroundColor = .whiteColor()
        opaque = true

        bodyView.addArrangedSubview(wordLabel)
        bodyView.addArrangedSubview(senseLabel)
        columnView.addArrangedSubview(bodyView)
        contentView.addSubview(columnView)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
