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
    
    private let wordLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textColor = UIColor(red: 247/255, green: 80/255, blue: 50/255, alpha: 1)
        label.font = UIFont(name: "HelveticaNeue", size: 36.0)
        label.textAlignment = NSTextAlignment.Center
        return label
    }()
    
    private let senseLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textColor = UIColor(red: 247/255, green: 80/255, blue: 50/255, alpha: 1)
        label.font = UIFont(name: "HelveticaNeue", size: 10.0)
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
        
        backgroundColor = UIColor(red: 244/255, green: 244/255, blue: 244/255, alpha: 1)
        opaque = true
        layer.borderColor = UIColor(red: 245/255, green: 80/255, blue: 60/255, alpha: 1).CGColor
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
