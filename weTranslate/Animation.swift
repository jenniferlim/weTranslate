//
//  Animation.swift
//  weTranslate
//
//  Created by Lionel on 2/21/16.
//  Copyright © 2016 weTranslate. All rights reserved.
//

import UIKit

func animate(duration: NSTimeInterval = 0.3, completion: ((Bool) -> Void)? = nil, animations: () -> Void) {
    UIView.animateWithDuration(duration, animations: animations, completion: completion)
}
