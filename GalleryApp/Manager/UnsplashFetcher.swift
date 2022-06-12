//
//  UnsplashApiFetcher.swift
//  GalleryApp
//
//  Created by ReliSource Technologies Ltd. on 6/6/22.
//

import Foundation
import Combine

class UnsplashFetcher {
    private let session: URLSession
    private var pageIndex = 0
    
    init(session: URLSession = .shared) {
        self.session = session
    }
}

// MARK: - UnsplashFetchable
extension UnsplashFetcher: UnsplashFetchable {
    
    func getUnsplashPhotos() -> AnyPublisher<[Photo], UnsplashError> {
        self.pageIndex += 1
        return fetchData(with: makeUnsplashAPIComponents(withPageIndex: self.pageIndex))
    }
    
    private func fetchData<T>(with components: URLComponents) -> AnyPublisher<T, UnsplashError> where T: Decodable {
        guard let url = components.url else {
            let error = UnsplashError.invalidURL(description: Constants.invalidUrlMessage)
            return Fail(error: error).eraseToAnyPublisher()
        }
        print(url)
        return session.dataTaskPublisher(for: URLRequest(url: url))
            .mapError { error in
                    .network(description: error.localizedDescription)
            }
            .flatMap(maxPublishers: .max(1)) { pair in
                decode(pair.data)
            }
            .eraseToAnyPublisher()
    }
}

// MARK: - UnSplash API

extension UnsplashFetcher {
    func makeUnsplashAPIComponents(withPageIndex index: Int) -> URLComponents {
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
