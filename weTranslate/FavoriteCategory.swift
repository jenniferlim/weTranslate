//
//  FavoriteCategory.swift
//  weTranslate
//
//  Created by Jennifer on 27/02/2016.
//  Copyright © 2016 weTranslate. All rights reserved.
//

import Foundation
import TranslateKit

struct FavoriteCategory {

    // MARK: - Properties

    let language: Language
    let translations: [Translation]


    // MARK: - Initialization

    init(language: Language, translations: [Translation]) {
        self.language = language
        self.translations = translations
    }
}


extension FavoriteCategory: DictionaryDeserializable, DictionarySerializable {

    init?(dictionary: JSONDictionary) {
        guard let languageRawValue = dictionary["language"] as? String,
            let language = Language(rawValue: languageRawValue),
            let translationDictionaries = dictionary["translations"] as? [JSONDictionary] else { return nil }

        self.language = language
        self.translations = translationDictionaries.flatMap { dictionary in
            return Translation(dictionary: dictionary)
        }
    }

    var dictionary: JSONDictionary {

        let translationsDictionary = translations.map { $0.dictionary }

        return [
            "language": language.name() as AnyObject,
            "translations" : translationsDictionary as AnyObject
        ]
    }
}
