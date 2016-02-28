//
//  ConfigurationTests.swift
//  weTranslate
//
//  Created by Lionel on 2/27/16.
//  Copyright © 2016 weTranslate. All rights reserved.
//

import XCTest
@testable import weTranslate

final class ConfigurationTests: XCTestCase {

    func testAPIKey() {
        XCTAssertEqual(AppCoordinator.configuration["API_KEY"] as? String, "API_KEY")
    }
}
