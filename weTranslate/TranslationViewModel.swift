//
//  TranslationViewModel.swift
//  weTranslate
//
//  Created by Lionel on 2/15/16.
//  Copyright © 2016 weTranslate. All rights reserved.
//

import Foundation
import TranslateKit

struct TranslationViewModel {

    let translation: Translation

    // MARK: - Init

    init(translation: Translation) {
        self.translation = translation
    }
}
