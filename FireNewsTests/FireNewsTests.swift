//
//  FireNewsTests.swift
//  FireNewsTests
//
//  Created by Tilak Shakya on 02/03/24.
//

import XCTest
@testable import FireNews

final class FireNewsTests: XCTestCase {
    
    var viewModel: NewsListViewModel!
    
    override func setUp() {
        super.setUp()
        viewModel = NewsListViewModel()
    }
    
    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }
    
    // Test fetching news data
    func testFetchNews() {
        let expectation = self.expectation(description: "Fetch News Expectation")
        
        viewModel.fetchNews { result in
            switch result {
            case .success:
                XCTAssertNotNil(self.viewModel.getArticles(), "Articles should not be nil after successful fetch")
                expectation.fulfill()
            case .failure(let error):
                XCTFail("Fetching news data failed with error: \(error)")
            }
        }
        
        waitForExpectations(timeout: 10, handler: nil)
    }
    
}
