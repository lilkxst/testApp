//
//  testAppTestsUnitTests.swift
//  testAppTestsUnitTests
//
//  Created by Артём Костянко on 13.10.23.
//

import Foundation
import XCTest
@testable import testApp

final class StickerLoaderTest: XCTestCase {
    
    func testSuccessLoading() throws {
        // Given
        let stubNetworkClient = StubNetworkClient(emulateError: false)
        let loader = StickerLoader(networkClient: stubNetworkClient)
        
        // When
        let expectation = expectation(description: "Loading expectation")
        loader.loadStickers { result in
            
            // Then
            switch result {
            case .success(let stickers):
                XCTAssertEqual(stickers.stickers.count, 1)
                expectation.fulfill()
            case .failure(_):
                XCTFail("Unexpected fail")
            }
        }
        waitForExpectations(timeout: 1)
    }
    
    func testFailureLoading() throws {
        // Given
        let stubNetworkClient = StubNetworkClient(emulateError: true)
        let loader = StickerLoader(networkClient: stubNetworkClient)
        
        // When
        let expectation = expectation(description: "Loading expectation")
        
        loader.loadStickers { result in
            switch result {
            case .success(_):
                XCTFail("Unexpected fail")
            case .failure(let error):
                XCTAssertNotNil(error)
                expectation.fulfill()
            }
        }
        waitForExpectations(timeout: 1)
    }
}

