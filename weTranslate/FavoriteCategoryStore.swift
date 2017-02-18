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

    fileprivate let favoriteCategoriesDatabase = Database<FavoriteCategory>(dbFileName: "favoriteCategoriesStore.json")!

    func insert(_ translation: Translation) -> () {

        let language = translation.fromLanguage == .English ? translation.fromLanguage : translation.toLanguage

        let updatedFavoriteCategory = add(translation, toLanguage: language)
        set(updatedFavoriteCategory)
    }

    func fetchAll() -> [FavoriteCategory] {
        return favoriteCategoriesDatabase.get()
    }

    func reset() {
        favoriteCategoriesDatabase.set([])
    }


    // MARK: - Private

    fileprivate func set(_ category: FavoriteCategory) {
        var favoriteCategories: [FavoriteCategory] = favoriteCategoriesDatabase.get().filter { $0.language != category.language }
        favoriteCategories.append(category)
        favoriteCategoriesDatabase.set(favoriteCategories)
    }

    fileprivate func add(_ translation: Translation, toLanguage language: Language) -> FavoriteCategory {
        let favoriteCategories: [FavoriteCategory] = favoriteCategoriesDatabase.get()
        let favoriteCategory = favoriteCategories.filter ({ $0.language == language }).first

        var translations = favoriteCategory?.translations.filter { $0 != translation } ?? []
        translations.append(translation)
        return FavoriteCategory(language: language, translations:translations)
    }
}
