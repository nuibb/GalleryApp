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
    
    init() {
        self.viewModel = GalleryViewModel(unsplashFetcher: UnsplashFetcher(), networkManager: NetworkManager())
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
            .navigationBarTitle("Gallery", displayMode: .large)
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
