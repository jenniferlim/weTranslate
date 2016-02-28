//
//  FavoriteCategory.swift
//  weTranslate
//
//  Created by Jennifer on 27/02/2016.
//  Copyright © 2016 weTranslate. All rights reserved.
//

import Foundation
import TranslateKit

struct FavoriteCategory: DictionaryDeserializable, DictionarySerializable {

    // MARK: - Properties

    let language: Language
    let translations: [Translation]


    // MARK: - Initialization

    init?(dictionary: JSONDictionary) {
        guard let languageRawValue = dictionary["language"] as? String,
            language = Language(rawValue: languageRawValue),
            translationsDictionary = dictionary["translations"] as? JSONDictionary else { return nil }

        self.language = language
        self.translations = translationsDictionary.flatMap({
            guard let dictionary = $0.1 as? JSONDictionary else { return nil }
            return Translation(dictionary: dictionary)
        })
    }

    init(language: Language, translations: [Translation]) {
        self.language = language
        self.translations = translations
    }

    var dictionary: JSONDictionary {

        let translationsDictionary = translations.map { $0.dictionary }

        return [
            "language": language.name(),
            "translations" : translationsDictionary
        ]
    }
}
