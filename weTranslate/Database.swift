//
//  Store.swift
//  weTranslate
//
//  Created by Jennifer on 24/02/2016.
//  Copyright © 2016 weTranslate. All rights reserved.
//

import Foundation
import TranslateKit

struct Database<T where T:DictionaryDeserializable, T:DictionarySerializable> {

    private let dbFilePath: String
    private let queue = dispatch_queue_create("com.fluen.fluenapp.Database", DISPATCH_QUEUE_CONCURRENT)
    init?(dbFileName: String) {
        guard let documentsDirectory = (NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)).first else { return nil }
        dbFilePath = (documentsDirectory as NSString).stringByAppendingPathComponent(dbFileName)
    }

    func get() -> [T] {
        var items = [T]()
        dispatch_sync(queue) {
            guard let data = NSData(contentsOfFile: self.dbFilePath),
                objects = try? NSJSONSerialization.JSONObjectWithData(data, options: []),
                dictionaries = objects as? [JSONDictionary] else { return }
            items = dictionaries.flatMap { T(dictionary: $0) }
        }
        return items
    }

    func set(items: [T]) {
        dispatch_barrier_async(queue) {
            let dictionaries = items.map { $0.dictionary }
            guard let data = try? NSJSONSerialization.dataWithJSONObject(dictionaries, options: []) else { return }
            data.writeToFile(self.dbFilePath, atomically: true)
        }
    }
}
