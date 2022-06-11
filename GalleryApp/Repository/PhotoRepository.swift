//
//  PhotoRepository.swift
//  GalleryApp
//
//  Created by ReliSource Technologies Ltd. on 6/8/22.
//

import Foundation
import RealmSwift

//Implementing repository design pattern
protocol PhotoRepository : BaseRepository {
    //For later scope
}


struct PhotoEntityRepository : PhotoRepository {
    
    typealias T = PhotoEntity
    let handler = DatabaseHandler.shared
    
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
        let fetchedObjects = handler.fetch(T.self, with: predicate)
        if fetchedObjects.count == 0 {
            handler.add(entity)
        }
    }
    
    func getAll() -> [T] {
        let results = handler.fetch(T.self)
        return results
    }
    
    func get(byIdentifier id: String) -> T? {
        return nil
    }
}

