//
//  CacheAsyncImage.swift
//  GalleryApp
//
//  Created by ReliSource Technologies Ltd. on 6/7/22.
//

import SwiftUI

struct CacheAsyncImage<Content>: View where Content: View {
    private let url: String
    private let scale: CGFloat
    private let transaction: Transaction
    private let content: (AsyncImagePhase) -> Content
    
    init(
        url: String,
        scale: CGFloat = 1.0,
        transaction: Transaction = Transaction(animation: .spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0.25)),
        @ViewBuilder content: @escaping (AsyncImagePhase) -> Content
    ) {
        self.url = url
        self.scale = scale
        self.transaction = transaction
        self.content = content
    }
    
    var body: some View {
        
        if let cached = ImageCache[url] {
            //let _ = print("cached \(url)")
            content(.success(cached))
        } else {
            //let _ = print("request \(url)")
            AsyncImage(
                url: URL(string: url),
                scale: scale,
                transaction: transaction
            ) { phase in
                cacheAndRender(phase: phase)
            }
        }
    }
    
    func cacheAndRender(phase: AsyncImagePhase) -> some View {
        if case .success(let image) = phase {
            ImageCache[url] = image
        }
        
        return content(phase)
    }
}

struct CacheAsyncImage_Previews: PreviewProvider {
    static let photos: [Photo] = Bundle.main.decode("photos.json")
    static let photosViewModel: PhotoViewModel = PhotoViewModel(photo: photos.first!)
    static var previews: some View {
        CacheAsyncImage(
            url: photosViewModel.thumbUrl
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

fileprivate class ImageCache {
    static private var cache: [String: Image] = [:]
    
    static subscript(url: String) -> Image? {
        get {
            ImageCache.cache[url]
        }
        set {
            ImageCache.cache[url] = newValue
        }
    }
}

