//
//  PhotoViewModel.swift
//  GalleryApp
//
//  Created by ReliSource Technologies Ltd. on 6/6/22.
//

import Foundation
import SwiftUI

struct PhotoViewModel: Identifiable, Equatable {
    private let photo: Photo
    
    var id: String {
        return photo.id
    }
    
    var rawUrl: String {
        return photo.urls.raw
    }
    
    var regularUrl: String {
        return photo.urls.regular
    }
    
    var fullUrl: String {
        return photo.urls.full
    }
    
    var thumbUrl: String {
        return photo.urls.thumb
    }
    
    init(photo: Photo) {
        self.photo = photo
    }
}
