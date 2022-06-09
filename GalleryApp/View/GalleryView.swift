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
    @ObservedObject var viewModel: GalleryViewModel
    private let unsplashFetcher: UnsplashFetchable
    private let databaseManager: DbProtocol
    private let photoEntityRepository: PhotoEntityRepository
    
    init() {
        self.unsplashFetcher = UnsplashFetcher()
        self.photoEntityRepository = PhotoEntityRepository()
        self.databaseManager = DatabaseManager(photoEntityRepository: photoEntityRepository)
        self.viewModel = GalleryViewModel(unsplashFetcher: self.unsplashFetcher, databaseManager: self.databaseManager)
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white]// for .inline, use titleTextAttributes
    }
    
    // MARK: - BODY
    var body: some View {
        NavigationView {
            Group {
                ZStack {
                    Color(.systemTeal)
                        .edgesIgnoringSafeArea(.all)
                    ScrollView(.vertical, showsIndicators: false) {
                        GridView(viewModel: self.viewModel)
                            .padding(10)
                            .animation(.spring(response: 1.5), value: true)
                    }
                } //: SCROLL
            } //: GROUP
            .navigationBarTitle(Constants.navigationTitle, displayMode: .large)
        }//: NAVIGATION
        .navigationViewStyle(.stack)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        GalleryView()
            .previewDevice("iPhone 12 Pro")
    }
}
