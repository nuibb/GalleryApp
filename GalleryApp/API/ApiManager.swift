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
        // See in which environment this version is building on
        Configuration.findCurrentEnvironment()// Change settings later according to environment
        
        var components = URLComponents()
        components.scheme = UnsplashAPI.scheme
        components.host = UnsplashAPI.host
        components.path = UnsplashAPI.path
        components.queryItems = [
            URLQueryItem(name: "page", value: String(index)),
            URLQueryItem(name: "per_page", value: String(UnsplashAPI.itemsPerPage)),
            URLQueryItem(name: "order_by", value: String(UnsplashAPI.orderby)),
            URLQueryItem(name: "client_id", value: UnsplashAPI.key)
        ]
        return components
    }
}
