//
//  MainViewControllerTests.swift
//  GitHubAppTests
//
//  Created by Sergey Tszyu on 21.07.2021.
//

import XCTest
@testable import GitHubApp

class MainViewControllerTests: XCTestCase {

    // MARK: - Properties
    private var viewController: MainViewController!
    
    // MARK: - Lyfecycle
    override func setUp() {
        super.setUp()
        
        viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MainViewController") as? MainViewController
        viewController.loadViewIfNeeded()
    }
    
    override func tearDown() {
        
        viewController = nil
        super.tearDown()
    }
    
    // MARK: - Test UITableViewDataSource
    func testIsConformToProtocolUITableViewDataSource() {
        XCTAssertNotNil(viewController as UITableViewDataSource)
    }
    
    // MARK: - Test UITableViewDelegate
    func testIsConformToProtocolUITableViewDelegate() {
        XCTAssertNotNil(viewController as UITableViewDelegate)
    }
    
    // MARK: - Test UISearchResultsUpdating
    func testIsConformToProtocolUISearchResultsUpdating() {
        XCTAssertNotNil(viewController as UISearchResultsUpdating)
    }
    
    // MARK: - Test UISearchBarDelegate
    func testIsConformToProtocolUISearchBarDelegate() {
        XCTAssertNotNil(viewController as UISearchBarDelegate)
    }

}
