//
//  GridView.swift
//  GalleryApp
//
//  Created by ReliSource Technologies Ltd. on 6/6/22.
//

import SwiftUI

struct GridView: View {
    
    // MARK: - PROPERTIES
    @State private var gridLayout: [GridItem] = [GridItem(.flexible())]
    @State private var gridColumn: Double = 3.0
    let viewModel: GalleryViewModel
    var index = 1
    
    // MARK: - BODY
    var body: some View {
        LazyVGrid(columns: gridLayout, alignment: .center, spacing: 10) {
            ForEach(viewModel.dataSource.indices, id:\.self) { index in
                NavigationLink(destination: PhotoDetailView(photoViewModel: viewModel.dataSource[index])) {
                    PhotoGridItemView(photoViewModel: viewModel.dataSource[index])
                        .onAppear(perform: {
                            if viewModel.dataSource[index] == viewModel.dataSource.last {
                                getNextPageIfNecessary(encounteredIndex: index)
                            }
                        })
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
    
    private func getNextPageIfNecessary(encounteredIndex: Int) {
        guard encounteredIndex == viewModel.dataSource.count - 1 else { return }
        self.viewModel.fetchPhotos(forIndex: self.viewModel.pageIndex)
    }
}

struct GridView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = GalleryViewModel(unsplashFetcher: UnsplashFetcher())
        GridView(viewModel: viewModel)
    }
}
