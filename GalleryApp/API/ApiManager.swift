//
//  ApiManager.swift
//  GalleryApp
//
//  Created by ReliSource Technologies Ltd. on 6/4/22.
//

import Foundation
import SwiftUI

class ApiManager {
    func makeUnsplashAPIComponents(withPagination index: Int) -> URLComponents {
        var components = URLComponents()
        components.scheme = UnsplashAPI.scheme
        components.host = UnsplashAPI.host
        components.path = UnsplashAPI.path
        components.queryItems = [
            URLQueryItem(name: "page", value: String(index)),
            URLQueryItem(name: "client_id", value: UnsplashAPI.key)
        ]
        return components
    }
}
