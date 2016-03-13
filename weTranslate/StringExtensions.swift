//
//  StringExtensions.swift
//  weTranslate
//
//  Created by Jennifer on 12/03/2016.
//  Copyright © 2016 weTranslate. All rights reserved.
//

import UIKit

extension String {

    func attributedString(withColor color: UIColor) -> NSAttributedString {
        let attributes = [NSForegroundColorAttributeName : color]
        return NSAttributedString(string: self, attributes: attributes)
    }
}
