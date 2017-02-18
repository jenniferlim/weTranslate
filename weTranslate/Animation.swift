//
//  Animation.swift
//  weTranslate
//
//  Created by Lionel on 2/21/16.
//  Copyright © 2016 weTranslate. All rights reserved.
//

import UIKit

func animate(_ duration: TimeInterval = 0.3, completion: ((Bool) -> Void)? = nil, animations: @escaping () -> Void) {
    UIView.animate(withDuration: duration, animations: animations, completion: completion)
}
