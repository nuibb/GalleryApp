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
    private let databaseManager: DbProtocol
    private var disposables = Set<AnyCancellable>()
    private let networkReachability = NetworkManager.shared
    
    //Dependancy Injection
    init(unsplashFetcher: UnsplashFetchable, databaseManager: DbProtocol) {
        self.unsplashFetcher = unsplashFetcher
        self.databaseManager = databaseManager
        if self.networkReachability.isNetworkAvailable() {
            self.fetchPhotos()
        } else {
            let photos = self.databaseManager.getAllPhotos()
            self.dataSource = photos.map { response in
                response.toMap()
            }
            //print("Count in DB: \(self.dataSource.count)")
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
                    let _ = self.dataSource.map { photo in
                        let photoEntity = PhotoEntity(value: ["photoId": photo.id, "thumbUrl": photo.thumbUrl])
                        self.databaseManager.addPhoto(entity: photoEntity)
                    }
                })
            .store(in: &disposables)
    }
}

extension GalleryViewModel {
}
