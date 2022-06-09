//
//  CacheAsyncImage.swift
//  GalleryApp
//
//  Created by ReliSource Technologies Ltd. on 6/7/22.
//

import SwiftUI

struct CacheAsyncImage<Content>: View where Content: View {
    private let viewModel: PhotoViewModel
    private let scale: CGFloat
    private let transaction: Transaction
    private let content: (AsyncImagePhase) -> Content
    
    init(
        viewModel: PhotoViewModel,
        scale: CGFloat = 1.0,
        transaction: Transaction = Transaction(animation: .spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0.25)),
        @ViewBuilder content: @escaping (AsyncImagePhase) -> Content
    ) {
        self.viewModel = viewModel
        self.scale = scale
        self.transaction = transaction
        self.content = content
    }
    
    var body: some View {
        //ImageCache[viewModel.thumbUrl]
        if let cachedUrl = URL(string: viewModel.thumbUrl),
           cachedUrl.checkIfFileExistsWith(name: viewModel.id),
           let image = cachedUrl.loadImage(imageName: viewModel.id)
        {
            //let _ = print("cached \(viewModel.thumbUrl)")
            content(.success(Image(uiImage: image))) //Loading images from in document directory
        } else {
            //let _ = print("request \(viewModel.thumbUrl)")
            AsyncImage(
                url: URL(string: viewModel.thumbUrl),
                scale: scale,
                transaction: transaction
            ) { phase in
                cacheAndRender(phase: phase)
            }
        }
    }
    
    func cacheAndRender(phase: AsyncImagePhase) -> some View {
        if case .success(_) = phase {//let image
            //ImageCache[viewModel.thumbUrl] = image
            saveImageToPhotoAlbum()
        }
        return content(phase)
    }
}

extension CacheAsyncImage {
    private func saveImageToPhotoAlbum() {
        if let imageURL = URL(string: viewModel.thumbUrl),
           let data = try? Data(contentsOf: imageURL),
           let image = UIImage(data: data) {
            imageURL.saveImage(image, name: viewModel.id)
            if let jpegImage = imageURL.loadImage(imageName: viewModel.id) {
                //print("Image Path: \(jpegImage)")
                UIImageWriteToSavedPhotosAlbum(jpegImage, nil, nil, nil)
            }
        }
    }
}

struct CacheAsyncImage_Previews: PreviewProvider {
    static let photos: [Photo] = Bundle.main.decode("photos.json")
    static let photosViewModel: PhotoViewModel = PhotoViewModel(photo: photos.first!)
    static var previews: some View {
        CacheAsyncImage(
            viewModel: photosViewModel
        ) { phase in
            switch phase {
            case .empty:
                ProgressView()
            case .success(let image):
                image
            case .failure(_):
                Image(systemName: "ant.circle.fill").iconModifier()
            @unknown default:
                fatalError()
            }
        }
    }
}
