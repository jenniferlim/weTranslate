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

    func insert(translation translation: Translation) -> () {

        let language = translation.fromLanguage == .English ? translation.fromLanguage : translation.toLanguage

        let updatedFavoriteCategory = add(translation: translation, toLanguage: language)
        set(category: updatedFavoriteCategory)
    }

    func fetchAll() -> [FavoriteCategory] {
        return favoriteCategoriesDatabase.get()
    }


    // MARK: - Private

    private func set(category category: FavoriteCategory) {
        var favoriteCategories: [FavoriteCategory] = favoriteCategoriesDatabase.get().filter { $0.language != category.language }
        favoriteCategories.append(category)
        favoriteCategoriesDatabase.set(favoriteCategories)
    }

    private func add(translation translation: Translation, toLanguage language: Language) -> FavoriteCategory {
        let favoriteCategories: [FavoriteCategory] = favoriteCategoriesDatabase.get()
        let favoriteCategory = favoriteCategories.filter ({ $0.language == language }).first

        var translations = favoriteCategory?.translations.filter { $0 != translation } ?? []
        translations.append(translation)
        return FavoriteCategory(language: language, translations:translations)
    }
}
