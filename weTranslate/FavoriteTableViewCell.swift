//
//  FavoriteTableViewCell.swift
//  weTranslate
//
//  Created by Jennifer on 09/03/2016.
//  Copyright © 2016 weTranslate. All rights reserved.
//

import UIKit

final class FavoriteTableViewCell: UITableViewCell {

    // MARK: - Properties

    var viewModel: FavoriteViewModel? {
        didSet {
            if let viewModel = viewModel {
                self.orignalWordLabel.text  = viewModel.searchText
                self.translatedWordLabel.text = viewModel.translatedText
            }
        }
    }

    private let orignalWordLabel: Label = {
        let label = Label(textColor: Color.brand, font: Font.font())
        label.numberOfLines = 0
        return label
    }()

    private let translatedWordLabel: Label = {
        let label = Label(textColor: Color.standardText, font: Font.font(style: .Caption1))
        label.numberOfLines = 0
        return label
    }()

    private let bodyView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .Vertical
        stackView.spacing = 5
        return stackView
    }()

    // MARK: - Init

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        contentView.opaque = true
        backgroundColor = .whiteColor()
        opaque = true

        bodyView.addArrangedSubview(orignalWordLabel)
        bodyView.addArrangedSubview(translatedWordLabel)

        addSubview(bodyView)

        bodyView.leadingAnchor.constraintEqualToAnchor(leadingAnchor).active = true
        bodyView.trailingAnchor.constraintEqualToAnchor(trailingAnchor).active = true
        bodyView.topAnchor.constraintEqualToAnchor(topAnchor).active = true
        bodyView.bottomAnchor.constraintEqualToAnchor(bottomAnchor).active = true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
