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

    private enum Action {
        case Add
        case Delete
    }

    private let favoriteCategoriesDatabase = Database<FavoriteCategory>(dbFileName: "favoriteCategoriesStore.json")!

    func insert(translation translation: Translation) -> () {
        let updatedFavoriteCategory = perform(action: .Add, onTranslation: translation)
        set(category: updatedFavoriteCategory)
    }

    func delete(translation translation: Translation) -> () {
        let updatedFavoriteCategory = perform(action: .Delete, onTranslation: translation)
        set(category: updatedFavoriteCategory)
    }

    func fetchAll() -> [FavoriteCategory] {
        return favoriteCategoriesDatabase.get()
    }

    func reset() {
        favoriteCategoriesDatabase.set([])
    }


    // MARK: - Private

    private func set(category category: FavoriteCategory) {
        var favoriteCategories: [FavoriteCategory] = favoriteCategoriesDatabase.get().filter { $0.language != category.language }
        favoriteCategories.append(category)
        favoriteCategoriesDatabase.set(favoriteCategories)
    }

    private func perform(action action: Action, onTranslation translation: Translation) -> FavoriteCategory {
        let language = translation.fromLanguage == .English ? translation.fromLanguage : translation.toLanguage
        let favoriteCategories: [FavoriteCategory] = favoriteCategoriesDatabase.get()
        let favoriteCategory = favoriteCategories.filter ({ $0.language == language }).first

        var translations = favoriteCategory?.translations.filter { $0 != translation } ?? []
        if case .Add = action {
            translations.append(translation)
        }

        return FavoriteCategory(language: language, translations:translations)
    }
}
