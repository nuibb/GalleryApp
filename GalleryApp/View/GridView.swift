//
//  GridView.swift
//  GalleryApp
//
//  Created by ReliSource Technologies Ltd. on 6/6/22.
//

import SwiftUI

struct GridView: View {
    
    // MARK: - PROPERTIES
    let viewModel: GalleryViewModel
    @State private var gridLayout: [GridItem] = [GridItem(.flexible())]
    @State private var gridColumn: Double = 3.0
    
    init(viewModel: GalleryViewModel) {
        self.viewModel = viewModel
    }
    
    // MARK: - BODY
    var body: some View {
        LazyVGrid(columns: gridLayout, alignment: .center, spacing: 10) {
            ForEach(viewModel.dataSource.indices, id:\.self) { index in
                NavigationLink(destination: PhotoDetailView(photoViewModel: viewModel.dataSource[index])) {
                    PhotoGridItemView(photoViewModel: viewModel.dataSource[index])
                        .task {
                            // Task is the same like onAppear, but works with async tasks.
                            // also it cancels the task when the view disappears.
                            if viewModel.dataSource[index] == viewModel.dataSource.last {
                                getNextPageIfNecessary(encounteredIndex: index)
                            }
                        }
                        .refreshable {
                            // Enable Pull to refresh
                        }
                    
                } //: LINK
            } //: LOOP
        }
        .onAppear(perform: {
            gridSwitch()
        })//: GRID
    }
    
    private func gridSwitch() {
        gridLayout = Array(repeating: .init(.flexible()), count: Int(gridColumn))
    }
    
    @MainActor private func getNextPageIfNecessary(encounteredIndex: Int) {
        guard encounteredIndex == viewModel.dataSource.count - 1 else { return }
        self.viewModel.fetchPhotos()
    }
}

struct GridView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = GalleryViewModel(unsplashFetcher: UnsplashFetcher(), databaseManager: DatabaseManager(photoEntityRepository: PhotoEntityRepository()))
        GridView(viewModel: viewModel)
    }
}
