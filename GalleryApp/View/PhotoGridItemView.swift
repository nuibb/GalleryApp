//
//  PhotoGridItemView.swift
//  GalleryApp
//
//  Created by ReliSource Technologies Ltd. on 6/5/22.
//

import SwiftUI

struct PhotoGridItemView: View {
    // MARK: - PROPERTIES
    let photoViewModel: PhotoViewModel
    
    // MARK: - BODY
    var body: some View {
        AsyncImage(url: URL(string: photoViewModel.thumbUrl), transaction: Transaction(animation: .spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0.25))) { phase in
          switch phase {
          case .success(let image):
            image
              .imageModifier()
              // .transition(.move(edge: .bottom))
              // .transition(.slide)
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

struct PhotoGridItemView_Previews: PreviewProvider {
    static let photos: [Photo] = Bundle.main.decode("photos.json")
    static let viewModels: [PhotoViewModel] = photos.map { photo in
        PhotoViewModel(photo: photo)
    }
    static var previews: some View {
        PhotoGridItemView(photoViewModel: viewModels[0])
    }
}
