//
//  Button.swift
//  weTranslate
//
//  Created by Jennifer on 23/02/2016.
//  Copyright © 2016 weTranslate. All rights reserved.
//

import UIKit

final class Button: UIButton {

    // MARK: - Init

    init(title: String, color: UIColor) {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        setTitle(title, forState: .Normal)
        setTitleColor(color, forState: .Normal)
        backgroundColor = Color.brand
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
