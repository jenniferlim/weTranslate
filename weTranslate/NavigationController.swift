//
//  NavigationController.swift
//  weTranslate
//
//  Created by Jennifer on 13/03/2016.
//  Copyright © 2016 weTranslate. All rights reserved.
//

import UIKit

final class NavigationController: UINavigationController {

    // MARK: - Init

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)

        navigationBar.barTintColor = Color.brand
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
