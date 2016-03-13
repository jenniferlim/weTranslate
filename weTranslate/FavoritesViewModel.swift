//
//  FavoriteViewModel.swift
//  weTranslate
//
//  Created by Jennifer on 09/03/2016.
//  Copyright © 2016 weTranslate. All rights reserved.
//

import Foundation
import TranslateKit

struct FavoriteViewModel {

    let translation: Translation

    var searchText: String {
        return translation.searchText
    }

    var translatedText: String {
        return translation.meanings[0].translatedWords[0].term
    }

    init(translation: Translation) {
        self.translation = translation
    }
}
