//
//  CassetteLoader.swift
//  weTranslate
//
//  Created by Lionel on 3/11/16.
//  Copyright © 2016 weTranslate. All rights reserved.
//

import Foundation

func loadJSON(file: String) -> AnyObject? {
    guard let URL = NSBundle(forClass: SentinelBundle.self).URLForResource(file, withExtension: "json"),
        data = NSData(contentsOfURL: URL) else { return nil }

    return try? NSJSONSerialization.JSONObjectWithData(data, options: [])
}

private class SentinelBundle: NSBundle {}
