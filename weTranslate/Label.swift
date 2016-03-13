//
//  Label.swift
//  weTranslate
//
//  Created by Jennifer on 23/02/2016.
//  Copyright © 2016 weTranslate. All rights reserved.
//

import UIKit

final class Label: UILabel {

    // MARK: - Init

    init(textColor: UIColor = Color.standardText, font: UIFont = Font.font()) {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        self.textColor = textColor
        self.font = font
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
