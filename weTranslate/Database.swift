//
//  Store.swift
//  weTranslate
//
//  Created by Jennifer on 24/02/2016.
//  Copyright © 2016 weTranslate. All rights reserved.
//

import Foundation
import TranslateKit

struct Database<T> where T:DictionaryDeserializable, T:DictionarySerializable {

    fileprivate let dbFilePath: String
    fileprivate let queue = DispatchQueue(label: "com.fluen.fluenapp.Database", attributes: DispatchQueue.Attributes.concurrent)
    init?(dbFileName: String) {
        guard let documentsDirectory = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)).first else { return nil }
        dbFilePath = (documentsDirectory as NSString).appendingPathComponent(dbFileName)
    }

    func get() -> [T] {
        var items = [T]()
        queue.sync {
            guard let data = try? Data(contentsOf: URL(fileURLWithPath: self.dbFilePath)),
                let objects = try? JSONSerialization.jsonObject(with: data, options: []),
                let dictionaries = objects as? [JSONDictionary] else { return }
            items = dictionaries.flatMap { T(dictionary: $0) }
        }
        return items
    }

    func set(_ items: [T]) {
        queue.async(flags: .barrier, execute: {
            let dictionaries = items.map { $0.dictionary }
            guard let data = try? JSONSerialization.data(withJSONObject: dictionaries, options: []) else { return }
            data.writeToFile(self.dbFilePath, atomically: true)
        }) 
    }
}
