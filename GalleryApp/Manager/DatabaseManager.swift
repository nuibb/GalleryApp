//
//  DatabaseManager.swift
//  GalleryApp
//
//  Created by ReliSource Technologies Ltd. on 6/8/22.
//

import Foundation

protocol DbProtocol {
    func addPhoto(entity: PhotoEntity)
    func getAllPhotos() -> [PhotoEntity]
}

struct DatabaseManager: DbProtocol
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
