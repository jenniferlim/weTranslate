//
//  MeaningViewModel.swift
//  weTranslate
//
//  Created by Lionel on 2/15/16.
//  Copyright © 2016 weTranslate. All rights reserved.
//

import Foundation
import TranslateKit

struct WordViewModel {

    let word: String
    let sense: String
    let originalSense: String

    init(word: TranslateKit.Word, originalWord: TranslateKit.Word) {
        self.word = word.term
        self.sense = word.sense
        self.originalSense = originalWord.sense
    }

    var isSenseHidden: Bool {
        return true
    }

    var isOriginalSenseHidden: Bool {
        return originalSense.isEmpty
    }
}
