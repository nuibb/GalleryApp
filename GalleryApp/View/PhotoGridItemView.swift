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
        CacheAsyncImage(
            viewModel: photoViewModel
        ) { phase in
            switch phase {
            case .success(let image):
                image
                    .imageModifier()
                // .transition(.move(edge: .bottom))
                // .transition(.slide)
                    .transition(.scale)
            case .failure(_):
                Image(systemName: Constants.failedPhaseIcon).iconModifier()
            case .empty:
                Image(systemName: Constants.emptyPhaseIcon).iconModifier()
            @unknown default:
                ProgressView()
            }
        }
        .padding(40)
    }
}

struct PhotoGridItemView_Previews: PreviewProvider {
    static let photos: [Photo] = Bundle.main.decode(Constants.pathForLocalJsonData)
    static let viewModel: PhotoViewModel = PhotoViewModel(photo: photos.first!)
    static var previews: some View {
        PhotoGridItemView(photoViewModel: viewModel)
    }
}
