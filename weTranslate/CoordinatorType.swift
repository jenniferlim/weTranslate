//
//  Coordinator.swift
//  weTranslate
//
//  Created by Lionel on 2/14/16.
//  Copyright © 2016 weTranslate. All rights reserved.
//

protocol CoordinatorType {
    var childCoordinators: [CoordinatorType] { get }
    func start()
}
