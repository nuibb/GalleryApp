//
//  UnsplashFetchable.swift
//  GalleryApp
//
//  Created by ReliSource Technologies Ltd. on 6/12/22.
//

import Foundation
import Combine

protocol UnsplashFetchable {
    func getUnsplashPhotos() -> AnyPublisher<[Photo], UnsplashError>
}
