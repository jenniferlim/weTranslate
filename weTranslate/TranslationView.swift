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
        return stackView
    }()
    
    
    // MARK: - Init
    
    override init(frame: CGRect = .zero) {
        
        super.init(frame: frame)
        
        backgroundColor = .whiteColor()
        opaque = true
        
        wordLabel.text = "Test"//viewModel.word.capitalizedString
        senseLabel.text = "subtitle"//"(\(viewModel.sense))"
        
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
