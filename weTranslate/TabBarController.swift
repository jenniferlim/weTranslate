//
//  TabBarController.swift
//  weTranslate
//
//  Created by Lionel on 2/14/16.
//  Copyright © 2016 weTranslate. All rights reserved.
//

import UIKit

final class TabBarController: UITabBarController {

    // MARK: - Initializers

    required init() {
        super.init(nibName: nil, bundle: nil)

        tabBar.translucent = false
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
