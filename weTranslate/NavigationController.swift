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

        initialize()
    }

    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)

        initialize()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func initialize() {
        navigationBar.tintColor = UIColor.whiteColor()
        navigationBar.barTintColor = Color.brand
        navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.whiteColor()]
    }
}
