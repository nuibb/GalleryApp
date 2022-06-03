//
//  APIHandler.swift
//  GalleryApp
//
//  Created by ReliSource Technologies Ltd. on 6/3/22.
//

import Foundation

class APIHandler {
    func fetchData<T: Codable>(_ url: String, completion: @escaping(T)->()) {
        if let url = URL(string: url) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error == nil {
                    if let safeData = data {
                        completion(self.decode(safeData) as T)
                    }
                }
            }
            task.resume()
        }
    }
}

extension APIHandler {
  func decode<T: Codable>(_ data: Data) -> T {
    // Create a decoder
    let decoder = JSONDecoder()
    // Create a property for the decoded data
    guard let results = try? decoder.decode(T.self, from: data) else {
      fatalError("Failed to decode!")
    }
    // Return the ready-to-use data
    return results
  }
}
