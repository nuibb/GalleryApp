//
//  APIHandler.swift
//  GalleryApp
//
//  Created by ReliSource Technologies Ltd. on 6/3/22.
//

import Foundation

class APIHandler<Element:Codable>: ObservableObject {
    
    //static let shared = APIHandler()
    static var shared:APIHandler<Element>{
        return APIHandler<Element>()
    }
    
    typealias T = Element
    @Published var elements = [T]()
    
    private func fetchData(_ url: String) {
        if let url = URL(string: url) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error == nil {
                    if let safeData = data {
                        self.elements  = self.decode(safeData)
                    }
                }
            }
            task.resume()
        }
    }
}

extension APIHandler {
  private func decode<T: Codable>(_ data: Data) -> T {
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
