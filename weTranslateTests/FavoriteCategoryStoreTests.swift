//
//  FavoriteCategoryStoreTests.swift
//  weTranslate
//
//  Created by Jennifer on 28/02/2016.
//  Copyright © 2016 weTranslate. All rights reserved.
//

import XCTest
import TranslateKit
@testable import weTranslate

class FavoriteCategoryStoreTests: XCTestCase {

    override func setUp() {
        FavoriteCategoryStore().reset()
    }

    func testFetchAll() {

        guard let dictionaries = loadJSON("favoriteCategoriesStore") as? [JSONDictionary],
            favoriteCategory = FavoriteCategory(dictionary: dictionaries[0]),
            translation = favoriteCategory.translations.first else {
                XCTFail()
                return
        }


        let favoriteCategoryStore = FavoriteCategoryStore()
        favoriteCategoryStore.insert(translation: translation)
        let favoriteCategories = favoriteCategoryStore.fetchAll()

        XCTAssertEqual(favoriteCategories.count, 1)
        XCTAssertEqual(favoriteCategories[0].translations.count, 1)
        XCTAssertEqual(favoriteCategories[0].translations[0].meanings[0].translatedWords.count, 2)
    }

}
