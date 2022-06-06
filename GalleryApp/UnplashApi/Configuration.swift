//
//  Configuration.swift
//  GalleryApp
//
//  Created by ReliSource Technologies Ltd. on 6/6/22.
//

import Foundation

struct Configuration {
    static func findCurrentEnvironment() {
        #if LOCAL
            print("Local Dev Builds!")
        #elseif DEV
            print("Dev Builds!")
        #elseif QA
            print("QA Builds!")
        #elseif PROD
            print("Production Builds!")
        #endif
    }
}
