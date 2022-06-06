//
//  ContentView.swift
//  GalleryApp
//
//  Created by ReliSource Technologies Ltd. on 6/2/22.
//

import SwiftUI
import Combine

struct GalleryView: View {
    
    // MARK: - PROPERTIES
    @State private var gridLayout: [GridItem] = [GridItem(.flexible())]
    @State private var gridColumn: Double = 3.0
    @ObservedObject var viewModel: GalleryViewModel
    
    // MARK: PROPERTIES
    init() {
        self.viewModel = GalleryViewModel(unsplashFetcher: UnsplashFetcher())
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white]// for .inline, use titleTextAttributes
    }

    func gridSwitch() {
        gridLayout = Array(repeating: .init(.flexible()), count: Int(gridColumn))
    }
    
    // MARK: - BODY
    var body: some View {
        NavigationView {
            Group {
                ZStack {
                    Color(.systemTeal)
                        .edgesIgnoringSafeArea(.all)
                    ScrollView(.vertical, showsIndicators: false) {
                        LazyVGrid(columns: gridLayout, alignment: .center, spacing: 10) {
                            ForEach(viewModel.dataSource.indices, id:\.self) { index in
                                NavigationLink(destination: PhotoDetailView(photoViewModel: viewModel.dataSource[index])) {
                                    PhotoGridItemView(photoViewModel: viewModel.dataSource[index])
                                        .onAppear(perform: {
                                            if viewModel.dataSource[index] == viewModel.dataSource.last {
                                                // getNextPageIfNecessary(encounteredIndex: index + 1)
                                            }
                                        })
                                        .task {
                                            
                                        }
                                } //: LINK
                            } //: LOOP
                        } //: GRID
                        .padding(10)
                        .animation(.spring(response: 1.5), value: true)
                    }
                } //: SCROLL
            } //: GROUP
            .navigationBarTitle("Gallery", displayMode: .large)
        }//: NAVIGATION
        .navigationViewStyle(.stack)
        .onAppear(perform: {
            gridSwitch()
        })
    }
    
    //    private func getNextPageIfNecessary(encounteredIndex: Int) {
    //        guard encounteredIndex == handler.elements.count - 1 else { return }
    //        let components = apiManager.makeUnsplashAPIComponents(withPagination: self.itemIndex)
    //        handler.elements.append(contentsOf: )
    //    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        GalleryView()
            .previewDevice("iPhone 12 Pro")
    }
}
