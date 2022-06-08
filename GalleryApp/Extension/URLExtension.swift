//
//  URLExtension.swift
//  GalleryApp
//
//  Created by ReliSource Technologies Ltd. on 6/8/22.
//

import SwiftUI

extension URL {
    func loadImage(imageName: String) -> UIImage? {
        if checkIfFileExistsWith(name: imageName) {
                let imageUrl = documentDirectoryPath()?.appendingPathComponent(imageName).appendingPathExtension("jpg")
                if let url = imageUrl, let data = try? Data(contentsOf: url), let loaded = UIImage(data: data) {
                    return loaded
                }
            
        }
        return nil
    }
    
    func saveImage(_ image: UIImage, name: String) {
        if !checkIfFileExistsWith(name: name) {
            if let jpgData = image.jpegData(compressionQuality: 0.5),
               let path = documentDirectoryPath()?.appendingPathComponent(name).appendingPathExtension("jpg") {
                //print(path)
                do {
                    try jpgData.write(to: path)
                } catch let error {
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func checkIfFileExistsWith(name: String) -> Bool {
        do {
            let documentDirectory = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            let fileUrl = documentDirectory.appendingPathComponent(name).appendingPathExtension("jpg")
            if FileManager.default.fileExists(atPath: fileUrl.path) {
                return true
            } else {
                return false
            }
        } catch {
            print(error)
            return false
        }
    }
    
    private func documentDirectoryPath() -> URL? {
        let path = FileManager.default.urls(for: .documentDirectory,
                                            in: .userDomainMask)
        return path.first
    }
}
