//
//  PhotoEntity.swift
//  GalleryApp
//
//  Created by ReliSource Technologies Ltd. on 6/8/22.
//

import Foundation
import RealmSwift

class PhotoEntity: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var id: ObjectId// This is our primary key, and each Photo instance can be uniquely identified by the ID
    @Persisted var photoId: String
    @Persisted var thumbUrl: String
    
    func toMap() -> PhotoViewModel {
        let urls = Urls(raw: "", full: "", regular: "", small: "", thumb: self.thumbUrl)
        let photo = Photo(id: self.photoId, urls: urls)
        return PhotoViewModel(photo: photo)
    }
}
