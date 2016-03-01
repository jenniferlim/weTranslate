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

    let word: String
    let fromLanguage: Language
    let toLanguage: Language

    init(word: String, fromLanguage: Language, toLanguage: Language) {
        self.word = word
        self.fromLanguage = fromLanguage
        self.toLanguage = toLanguage
    }

    var message: String {
        return localize("TRANSLATION_NOT_FOUND_FORMAT", word, toLanguage.name())
    }

    var emoji: String {
        return "🤔"
    }
}
