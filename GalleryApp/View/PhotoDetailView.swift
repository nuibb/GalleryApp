//
//  PhotoDetailView.swift
//  GalleryApp
//
//  Created by ReliSource Technologies Ltd. on 6/5/22.
//

import SwiftUI

struct PhotoDetailView: View {
    
    // MARK: - PROPERTIES
    let photoViewModel: PhotoViewModel

    // MARK: - BODY
    var body: some View {
        AsyncImage(url: URL(string: photoViewModel.thumbUrl), transaction: Transaction(animation: .spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0.25))) { phase in
          switch phase {
          case .success(let image):
            image
              .resizable()
              .scaledToFit()
              .transition(.scale)
          case .failure(_):
            Image(systemName: "ant.circle.fill").iconModifier()
          case .empty:
            Image(systemName: "photo.circle.fill").iconModifier()
          @unknown default:
            ProgressView()
          }
        }
        .padding(40)
    }
}

struct PhotoDetailView_Previews: PreviewProvider {
    static let photos: [Photo] = Bundle.main.decode("photos.json")
    static let photosViewModels: [PhotoViewModel] = photos.map { response in
        PhotoViewModel(photo: response)
    }
    static var previews: some View {
        PhotoDetailView(photoViewModel: photosViewModels[0])
    }
}
