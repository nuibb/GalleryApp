//
//  Parsing.swift
//  GalleryApp
//
//  Created by ReliSource Technologies Ltd. on 6/6/22.
//

import Foundation
import Combine

func decode<T: Decodable>(_ data: Data) -> AnyPublisher<T, UnsplashError> {
  let decoder = JSONDecoder()
  decoder.dateDecodingStrategy = .secondsSince1970

  return Just(data)
    .decode(type: T.self, decoder: decoder)
    .mapError { error in
      .decoding(description: error.localizedDescription)
    }
    .eraseToAnyPublisher()
}

