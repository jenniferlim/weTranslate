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

    fileprivate let overlayView: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black
        view.layer.opacity = 0.2
        return view
    }()

    fileprivate let backgroundImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        return imageView
    }()

    fileprivate let wordsCountOverlayView: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black
        view.layer.opacity = 0.6
        view.layoutMargins = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
        view.layer.cornerRadius = 5
        view.layer.masksToBounds = true
        return view
    }()

    fileprivate let wordsCountLabel: Label = {
        let label = Label(textColor: .white, font: Font.font(.subheadline))
        label.numberOfLines = 0
        return label
    }()

    fileprivate let languageLabel: Label = {
        let label = Label(textColor: .white, font: Font.font(.title1, weight: .medium))
        label.numberOfLines = 0
        return label
    }()

    fileprivate let columnView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .center
        stackView.spacing = 10
        return stackView
    }()

    fileprivate let bodyView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 5
        return stackView
    }()


    // MARK: - Init

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        contentView.isOpaque = true
        backgroundColor = Color.background
        isOpaque = true

        wordsCountOverlayView.addSubview(wordsCountLabel)

        bodyView.addArrangedSubview(languageLabel)
        bodyView.addArrangedSubview(wordsCountOverlayView)
        columnView.addArrangedSubview(bodyView)

        contentView.addSubview(overlayView)
        contentView.addSubview(columnView)
        backgroundView = backgroundImageView

        let margins = contentView.layoutMarginsGuide
        columnView.leadingAnchor.constraint(equalTo: margins.leadingAnchor).isActive = true
        columnView.trailingAnchor.constraint(equalTo: margins.trailingAnchor).isActive = true
        columnView.topAnchor.constraint(equalTo: margins.topAnchor).isActive = true
        columnView.bottomAnchor.constraint(equalTo: margins.bottomAnchor).isActive = true

        overlayView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        overlayView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        overlayView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        overlayView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true

        wordsCountLabel.leadingAnchor.constraint(equalTo: wordsCountOverlayView.layoutMarginsGuide.leadingAnchor).isActive = true
        wordsCountLabel.trailingAnchor.constraint(equalTo: wordsCountOverlayView.layoutMarginsGuide.trailingAnchor).isActive = true
        wordsCountLabel.topAnchor.constraint(equalTo: wordsCountOverlayView.layoutMarginsGuide.topAnchor).isActive = true
        wordsCountLabel.bottomAnchor.constraint(equalTo: wordsCountOverlayView.layoutMarginsGuide.bottomAnchor).isActive = true

        languageLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
