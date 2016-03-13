//
//  NoResultViewModel.swift
//  weTranslate
//
//  Created by Lionel on 2/28/16.
//  Copyright © 2016 weTranslate. All rights reserved.
//

import Foundation
import TranslateKit

struct NoResultViewModel {

    // MARK: - Properties

    let searchText: String
    let fromLanguage: Language
    let toLanguage: Language


    // MARK: - Initializer

    init(searchText: String, fromLanguage: Language, toLanguage: Language) {
        self.searchText = searchText
        self.fromLanguage = fromLanguage
        self.toLanguage = toLanguage
    }

    var message: String {
        return localize("TRANSLATION_NOT_FOUND_FORMAT", searchText, toLanguage.name())
    }

    var emoji: String {
        return "🤔"
    }
}
