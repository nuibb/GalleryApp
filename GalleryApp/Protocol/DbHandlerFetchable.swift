//
//  DbHandlerFetchable.swift
//  GalleryApp
//
//  Created by ReliSource Technologies Ltd. on 6/12/22.
//

import Foundation
import RealmSwift

protocol DbHandlerFetchable {
    func add<T: Object>(_ object: T)
    func fetch<T: Object>(_ type: T.Type, with predicate: NSPredicate?) -> [T]
    func fetchById<T: Object>(id: String) -> T?
    func update<T: Object>(id: ObjectId, with predicate: NSPredicate?) -> T?
    func updateById<T: Object, value>(id: String, forValue: value) -> T?
    func delete<T: Object>(id: ObjectId, with predicate: NSPredicate?) -> (T?, Bool)
    func deleteById<T: Object>(id: String) -> (T?, Bool)
}
