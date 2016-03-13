//
//  SearchHeaderViewModel.swift
//  weTranslate
//
//  Created by Lionel on 2/21/16.
//  Copyright © 2016 weTranslate. All rights reserved.
//

import Foundation
import TranslateKit

struct SearchHeaderViewModel {

    // MARK: - Properties

    let languages: [Language] = Language.allLanguages()

    var selectedLanguage: Language = .French

    var selectedRow: Int {
        let language = fromLanguage == .English ? toLanguage : fromLanguage
        return languages.indexOf(language) ?? 0
    }

    var fromLanguage: Language {
        return translateFromEnglish ? .English : selectedLanguage
    }

    var toLanguage: Language {
        return translateFromEnglish ? selectedLanguage : .English
    }

    var translateFromEnglish: Bool = true


    // MARK: - Methods

    mutating func swap() {
        translateFromEnglish = !translateFromEnglish
    }
}
