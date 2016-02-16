//
//  UITableViewCellExtensions.swift
//  weTranslate
//
//  Created by Lionel on 2/15/16.
//  Copyright © 2016 weTranslate. All rights reserved.
//

import Foundation
import UIKit

extension UITableViewCell {
    static var cellIdentifier: String {
        return NSStringFromClass(self)
    }
}
