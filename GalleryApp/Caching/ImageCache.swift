//
//  ImageCache.swift
//  GalleryApp
//
//  Created by ReliSource Technologies Ltd. on 6/8/22.
//

import SwiftUI

class ImageCache {
    static private var cache: [String: Image] = [:]
    
    static subscript(url: String) -> Image? {
        get {
            ImageCache.cache[url]
        }
        set {
            ImageCache.cache[url] = newValue
        }
    }
    
    
}
