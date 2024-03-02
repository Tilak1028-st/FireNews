//
//  NewsListViewControllerTests.swift
//  FireNewsTests
//
//  Created by Tilak Shakya on 02/03/24.
//

import XCTest
@testable import FireNews

final class NewsListViewControllerTests: XCTestCase {
    
    var viewController: NewsListViewController!
    
    override func setUp() {
        super.setUp()
        let storyboard = UIStoryboard(name: "Main", bundle: nil) // Update with your storyboard name
        viewController = storyboard.instantiateViewController(withIdentifier: "NewsListViewController") as? NewsListViewController
        viewController.loadViewIfNeeded()
    }
    
    override func tearDown() {
        viewController = nil
        super.tearDown()
    }
    
    // Test refresh control setup
    func testRefreshControlSetup() {
        XCTAssertNotNil(viewController.refreshControl, "Refresh control should not be nil")
        XCTAssertTrue(viewController.newsListTableView.refreshControl === viewController.refreshControl, "Refresh control should be set as table view's refresh control")
    }
    
    // Test table view cell population
    func testTableViewCellPopulation() {
        let source = Source(id: "wired", name: "Wired")
        let article = Articles(source: source, author: "Simon Hill", title: "Xiaomi Redmi Note 13 Pro+ Review: Attractive and Affordable", description: "Xiaomi’s top Redmi phone can compete with flagships, but it still has some limitations.", url: "https://www.wired.com/review/xiaomi-redmi-note-13-pro-plus/", urlToImage: "https://media.wired.com/photos/65d8d475c84c2777e71bbac0/191:100/w_1280,c_limit/Gear-Featured-Xiaomi_Redmi_Note_13_Pro_Plus_2-SOURCE-Simon-Hill.jpg", publishedAt: "2024-02-24T09:00:00Z", content: "Daytime shots with the main camera are detailed, with a decent depth of field, but it doesnt always nail the exposure, and colors sometimes appear oversaturated. Theres a warm, pink tone evident in s… [+2408 chars]")
        viewController.newsViewModel.articles = [article]
        
        let tableView = viewController.newsListTableView
        let indexPath = IndexPath(row: 0, section: 0)
        guard let cell = viewController.tableView(tableView ?? UITableView(), cellForRowAt: indexPath) as? NewsListTableViewCell else {
            XCTFail("Cell should not be nil")
            return
        }
        
        XCTAssertEqual(cell.titleLabel.text, article.title, "Cell title label should match article title")
    }
}
