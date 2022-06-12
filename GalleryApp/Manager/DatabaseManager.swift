//
//  DatabaseManager.swift
//  GalleryApp
//
//  Created by ReliSource Technologies Ltd. on 6/8/22.
//

import Foundation

struct DatabaseManager: DbManagerFetchable
{
    private let photoEntityRepository: PhotoEntityRepository
    
    // Dependancy Injection
    init(photoEntityRepository: PhotoEntityRepository) {
        self.photoEntityRepository = photoEntityRepository
    }
    
    func addPhoto(entity: PhotoEntity)
    {
        photoEntityRepository.add(entity: entity)
    }
    
    func getAllPhotos() -> [PhotoEntity]
    {
        return photoEntityRepository.getAll()
    }
}
