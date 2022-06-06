//
//  PhotosViewModel.swift
//  GalleryApp
//
//  Created by ReliSource Technologies Ltd. on 6/6/22.
//

import SwiftUI
import Combine

class GalleryViewModel: ObservableObject {
    @Published var dataSource: [PhotoViewModel] = []
    
    private let unsplashFetcher: UnsplashFetchable
    private var disposables = Set<AnyCancellable>()
    
    //Dependancy Injection
    init(unsplashFetcher: UnsplashFetchable) {
        self.unsplashFetcher = unsplashFetcher
        fetchPhotos()
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
                    self.dataSource = photosViewModels
                })
            .store(in: &disposables)
    }
}

extension GalleryViewModel {
}
