//
//  SearchViewModel.swift
//  weTranslate
//
//  Created by Lionel on 2/15/16.
//  Copyright © 2016 weTranslate. All rights reserved.
//

import Foundation
// FIXME: add TranslateKit dependancy using Carthage
//import TranslateKit
import TranslateKit

struct SearchViewModel {
    
    let translation: Translation
    
    // MARK: - Init
    
    init(translation: Translation) {
        self.translation = translation
    }
}
