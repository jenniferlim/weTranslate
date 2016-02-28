//
//  FontTests.swift
//  weTranslate
//
//  Created by Lionel on 2/27/16.
//  Copyright © 2016 weTranslate. All rights reserved.
//

import XCTest
@testable import weTranslate

class FontTests: XCTestCase {

    func testDefaultFont() {
        let font = Font.font()
        XCTAssertEqual(font.fontName, ".SFUIText-Regular")
        XCTAssertEqual(font.pointSize, 18.0)
    }

    func testTitle1Font() {
        let font = Font.font(style: .Title1)
        XCTAssertEqual(font.fontName, ".SFUIDisplay-Light")
        XCTAssertEqual(font.pointSize, 29.0)
    }

    func testTitle1UltraLightFont() {
        let font = Font.font(style: .Title1, weight: .UltraLight)
        XCTAssertEqual(font.fontName, ".SFUIDisplay-Ultralight")
        XCTAssertEqual(font.pointSize, 29.0)
    }
}
