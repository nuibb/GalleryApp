//
//  PhotoRepository.swift
//  GalleryApp
//
//  Created by ReliSource Technologies Ltd. on 6/8/22.
//

import Foundation
import RealmSwift

struct PhotoEntityRepository : PhotoRepository {
    
    typealias T = PhotoEntity
    private let handler: DbHandlerFetchable
    
    // Dependancy Injection
    init(handler: DbHandlerFetchable) {
        self.handler = handler
    }
    
    //    func mapper<T: Object>(object: T) -> T? {
    //        switch (T.self) {
    //        case is PhotoEntity.Type:
    //            return PhotoEntity() as? T
    //        default:
    //            return nil
    //        }
    //    }
    
    func add(entity: T) {
        let predicate = NSPredicate(format: "photoId == %@", entity.photoId)
        let fetchedObjects = self.handler.fetch(T.self, with: predicate)
        if fetchedObjects.count == 0 {
            self.handler.add(entity)
        }
    }
    
    func getAll() -> [T] {
        let results = self.handler.fetch(T.self, with: nil)
        return results
    }
    
    func get(byIdentifier id: String) -> T? {
        return nil
    }
}

