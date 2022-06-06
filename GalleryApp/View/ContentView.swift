//
//  ContentView.swift
//  GalleryApp
//
//  Created by ReliSource Technologies Ltd. on 6/2/22.
//

import SwiftUI

struct ContentView: View {
    
    // MARK: - PROPERTIES
    let apiManager = ApiManager()
    @ObservedObject var handler = APIHandler<Photo>.shared;
    @State private var gridLayout: [GridItem] = [GridItem(.flexible())]
    @State private var gridColumn: Double = 3.0
    @State private var itemIndex = 1
    
    func gridSwitch() {
        gridLayout = Array(repeating: .init(.flexible()), count: Int(gridColumn))
    }
    
    init() {
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
                        LazyVGrid(columns: gridLayout, alignment: .center, spacing: 10) {
                            ForEach(handler.elements.indices, id:\.self) { index in
                                NavigationLink(destination: PhotoDetailView(photo: handler.elements[index])) {
                                    PhotoGridItemView(photo: handler.elements[index])
                                        .onAppear(perform: {
                                            if handler.elements[index] == handler.elements.last {
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
            let components = apiManager.makeUnsplashAPIComponents(withPagination: self.itemIndex)
            handler.fetchData(with: components)
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
    let photos: [Photo] = Bundle.main.decode("photos.json")
    static var previews: some View {
        ContentView()
            .previewDevice("iPhone 12 Pro")
    }
}
