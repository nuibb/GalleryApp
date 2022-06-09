//
//  UnsplashApiResponseUnitTests.swift
//  GalleryAppTests
//
//  Created by ReliSource Technologies Ltd. on 6/9/22.
//

import XCTest
@testable import GalleryApp
import Combine

class UnsplashApiUnitTests: XCTestCase {
    
    func test_UnsplashApiResource_With_ValidRequest_Returns_ValidResponse() {

        // ARRANGE
        var dataSource: [Photo] = []
        var disposables = Set<AnyCancellable>()
        let fetcher = UnsplashFetcher()
        let expectation = self.expectation(description: "ValidRequest_Returns_ValidResponse")

        // ACT
        fetcher.getUnsplashPhotos()
            .sink(
                receiveCompletion: { [weak self] value in
                    guard self != nil else { return }
                    switch value {
                    case .failure(let error):
                        dataSource = []
                        print("Error: \(error.localizedDescription)")
                    case .finished:
                        break
                    }
                },
                receiveValue: { [weak self] photos in
                    guard self != nil else { return }
                    dataSource.append(contentsOf: photos)
                    
                    // ASSERT
                    XCTAssertNotNil(dataSource)
                    XCTAssertNotEqual(0, dataSource.count)
                    expectation.fulfill()
                })
            .store(in: &disposables)
        
        waitForExpectations(timeout: 5, handler: nil)
    }
}
