//
//  FavoriteCategoriesTableViewCell.swift
//  weTranslate
//
//  Created by Jennifer on 28/02/2016.
//  Copyright © 2016 weTranslate. All rights reserved.
//

import UIKit

final class FavoriteCategoriesTableViewCell: UITableViewCell {

    // MARK: - Properties

    var viewModel: FavoriteCategoryViewModel? {
        didSet {
            if let viewModel = viewModel {
                wordsCountLabel.text = "\(viewModel.wordsCount) words"
                languageLabel.text = viewModel.toLanguage.name()
                backgroundImageView.image = UIImage(named: viewModel.background)
            }
        }
    }

    private let overlayView: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .blackColor()
        view.layer.opacity = 0.2
        return view
    }()

    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        return imageView
    }()

    private let wordsCountOverlayView: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .blackColor()
        view.layer.opacity = 0.6
        view.layoutMargins = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
        return view
    }()

    private let wordsCountLabel: Label = {
        let label = Label(textColor: .whiteColor(), font: Font.font(style: .Subheadline))
        label.numberOfLines = 0
        return label
    }()

    private let languageLabel: Label = {
        let label = Label(textColor: .whiteColor(), font: Font.font(style: .Title1, weight: .Medium))
        label.numberOfLines = 0
        return label
    }()

    private let columnView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .Center
        stackView.spacing = 10
        return stackView
    }()

    private let bodyView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .Vertical
        stackView.alignment = .Center
        stackView.spacing = 5
        return stackView
    }()


    // MARK: - Init

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        contentView.opaque = true
        backgroundColor = Color.background
        opaque = true

        wordsCountOverlayView.addSubview(wordsCountLabel)

        bodyView.addArrangedSubview(languageLabel)
        bodyView.addArrangedSubview(wordsCountOverlayView)
        columnView.addArrangedSubview(bodyView)

        contentView.addSubview(overlayView)
        contentView.addSubview(columnView)
        backgroundView = backgroundImageView

        let margins = contentView.layoutMarginsGuide
        columnView.leadingAnchor.constraintEqualToAnchor(margins.leadingAnchor).active = true
        columnView.trailingAnchor.constraintEqualToAnchor(margins.trailingAnchor).active = true
        columnView.topAnchor.constraintEqualToAnchor(margins.topAnchor).active = true
        columnView.bottomAnchor.constraintEqualToAnchor(margins.bottomAnchor).active = true

        overlayView.leadingAnchor.constraintEqualToAnchor(contentView.leadingAnchor).active = true
        overlayView.trailingAnchor.constraintEqualToAnchor(contentView.trailingAnchor).active = true
        overlayView.topAnchor.constraintEqualToAnchor(contentView.topAnchor).active = true
        overlayView.bottomAnchor.constraintEqualToAnchor(contentView.bottomAnchor).active = true

        wordsCountLabel.leadingAnchor.constraintEqualToAnchor(wordsCountOverlayView.layoutMarginsGuide.leadingAnchor).active = true
        wordsCountLabel.trailingAnchor.constraintEqualToAnchor(wordsCountOverlayView.layoutMarginsGuide.trailingAnchor).active = true
        wordsCountLabel.topAnchor.constraintEqualToAnchor(wordsCountOverlayView.layoutMarginsGuide.topAnchor).active = true
        wordsCountLabel.bottomAnchor.constraintEqualToAnchor(wordsCountOverlayView.layoutMarginsGuide.bottomAnchor).active = true

        languageLabel.heightAnchor.constraintEqualToConstant(50).active = true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
