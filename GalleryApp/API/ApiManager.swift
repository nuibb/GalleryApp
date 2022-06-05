//
//  ApiManager.swift
//  GalleryApp
//
//  Created by ReliSource Technologies Ltd. on 6/4/22.
//

import Foundation
import SwiftUI

class ApiManager {
    @ObservedObject var handler = APIHandler<Photo>.shared;
    
    func getPhotos() -> [Photo] {
        return handler.elements
    }
    
}
