//
//  UnsplashApiError.swift
//  GalleryApp
//
//  Created by ReliSource Technologies Ltd. on 6/6/22.
//

import Foundation

enum UnsplashError: Error {
    case statusCode
    case decoding(description: String)
    case invalidImage
    case invalidURL(description: String)
    case network(description: String)
    case other(Error)
    
    static func map(_ error: Error) -> UnsplashError {
        return (error as? UnsplashError) ?? .other(error)
    }
}

