//
//  PhotosViewModel.swift
//  GalleryApp
//
//  Created by ReliSource Technologies Ltd. on 6/6/22.
//

import SwiftUI
import Combine

@MainActor
class GalleryViewModel: ObservableObject {
    
    @Published var dataSource: [PhotoViewModel] = []
    private let unsplashFetcher: UnsplashFetchable
    private var disposables = Set<AnyCancellable>()
    private var networkManager: NetworkManager
    
    //Dependancy Injection
    init(unsplashFetcher: UnsplashFetchable, networkManager: NetworkManager) {
        self.unsplashFetcher = unsplashFetcher
        self.networkManager = networkManager
        if self.networkManager.isConnectedToNetwork() {
            self.fetchPhotos()
        } else {
            print("KK")
        }
    }
    
    func fetchPhotos() {
        unsplashFetcher.getUnsplashPhotos()
            .map { response in
                response.map(PhotoViewModel.init)
            }
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { [weak self] value in
                    guard let self = self else { return }
                    switch value {
                    case .failure(let error):
                        self.dataSource = []
                        print("Error: \(error.localizedDescription)")
                    case .finished:
                        break
                    }
                },
                receiveValue: { [weak self] photosViewModels in
                    guard let self = self else { return }
                    self.dataSource.append(contentsOf: photosViewModels)
                })
            .store(in: &disposables)
    }
}

extension GalleryViewModel {
}
