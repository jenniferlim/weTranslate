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

    init(word: TranslateKit.Word) {
        self.word = word.term
        self.sense = word.sense
    }

}
