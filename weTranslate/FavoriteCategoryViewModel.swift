//
//  FavoritesViewModel.swift
//  weTranslate
//
//  Created by Jennifer on 27/02/2016.
//  Copyright © 2016 weTranslate. All rights reserved.
//

import Foundation
import TranslateKit

struct FavoriteCategoryViewModel {

    let favoriteCategory: FavoriteCategory
    let wordsCount: Int
    let toLanguage: Language
    let background: String

    // MARK: - Init

    init(favoriteCategory: FavoriteCategory) {
        self.favoriteCategory = favoriteCategory
        self.wordsCount = favoriteCategory.translations.count
        self.toLanguage = favoriteCategory.language
        self.background = favoriteCategory.language.name()
    }
}
