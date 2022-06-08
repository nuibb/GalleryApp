//
//  PhotoDetailView.swift
//  GalleryApp
//
//  Created by ReliSource Technologies Ltd. on 6/5/22.
//

import SwiftUI

struct PhotoDetailView: View {
    
    // MARK: - PROPERTIES
    private let viewModel: PhotoViewModel
    @State var items: [Any] = []
    @State var sheet = false
    
    init(photoViewModel: PhotoViewModel) {
        self.viewModel = photoViewModel
    }
    
    // MARK: - BODY
    var body: some View {
        VStack{
            AsyncImage(url: URL(string: viewModel.thumbUrl), transaction: Transaction(animation: .spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0.25))) { phase in
                switch phase {
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFit()
                        .transition(.scale)
                case .failure(_):
                    Image(systemName: Constants.failedPhaseIcon).iconModifier()
                case .empty:
                    Image(systemName: Constants.emptyPhaseIcon).iconModifier()
                @unknown default:
                    ProgressView()
                }
            }
            Spacer()
                .frame(height: 50)
            Button(action: {
                //self.items.removeAll()
                self.sheet.toggle()
            }, label: {
                Text(Constants.shareImageTitle)
                    .fontWeight(.heavy)
            })
            .sheet(isPresented: $sheet, onDismiss: {
                
            }, content: {
                ActivityViewController(activityItems: [URL(string: viewModel.thumbUrl)!])
            })
        }
        .padding(40)
    }
}

struct PhotoDetailView_Previews: PreviewProvider {
    static let photos: [Photo] = Bundle.main.decode("photos.json")
    static let viewModel: PhotoViewModel = PhotoViewModel(photo: photos.first!)
    static var previews: some View {
        PhotoDetailView(photoViewModel: viewModel)
    }
}
