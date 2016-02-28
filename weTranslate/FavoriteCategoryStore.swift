//
//  FavoriteCategoryStore.swift
//  weTranslate
//
//  Created by Jennifer on 28/02/2016.
//  Copyright © 2016 weTranslate. All rights reserved.
//

import Foundation
import TranslateKit

struct FavoriteCategoryStore {

    private let favoriteCategoriesDatabase = Database<FavoriteCategory>(dbFileName: "favoriteCategoriesStore.json")!

    func insert(translation translation: Translation, fromLanguage: Language, toLanguage: Language) -> () {

        var favoriteCategories: [FavoriteCategory] = favoriteCategoriesDatabase.get()

        let language = fromLanguage == .English ? fromLanguage : toLanguage

        var newTranslations = [translation]
        if let favoriteCategoryLg = favoriteCategories.filter ({ $0.language == language }).first {
            newTranslations.appendContentsOf((favoriteCategoryLg.translations))
        }

        favoriteCategories = favoriteCategories.filter { $0.language != language }
        let newFavoriteCategory = FavoriteCategory(language: language, translations: newTranslations)
        favoriteCategories.append(newFavoriteCategory)

        favoriteCategoriesDatabase.set(favoriteCategories)
    }
}
