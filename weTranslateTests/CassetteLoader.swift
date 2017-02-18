//
//  CassetteLoader.swift
//  weTranslate
//
//  Created by Lionel on 3/11/16.
//  Copyright © 2016 weTranslate. All rights reserved.
//

import Foundation

func loadJSON(_ file: String) -> AnyObject? {
    guard let URL = Bundle(for: SentinelBundle.self).url(forResource: file, withExtension: "json"),
        let data = try? Data(contentsOf: URL) else { return nil }

    return try! JSONSerialization.jsonObject(with: data, options: []) as AnyObject?
}

private class SentinelBundle: Bundle {}
