//
//  DbManagerFetchable.swift
//  GalleryApp
//
//  Created by ReliSource Technologies Ltd. on 6/12/22.
//

import Foundation

protocol DbManagerFetchable {
    func addPhoto(entity: PhotoEntity)
    func getAllPhotos() -> [PhotoEntity]
}
