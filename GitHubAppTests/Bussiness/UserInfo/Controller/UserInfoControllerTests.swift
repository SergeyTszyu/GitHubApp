//
//  UserInfoControllerTests.swift
//  GitHubAppTests
//
//  Created by Sergey Tszyu on 21.07.2021.
//

import XCTest
@testable import GitHubApp

class UserInfoControllerTests: XCTestCase {

    // MARK: - Properties
    private var viewController: UserInfoViewController!
    
    // MARK: - Lyfecycle
    override func setUp() {
        super.setUp()
        
        viewController = UIStoryboard(name: "UserInfo", bundle: nil).instantiateViewController(withIdentifier: "UserInfoViewController") as? UserInfoViewController
        viewController.loadViewIfNeeded()
    }
    
    override func tearDown() {
        
        viewController = nil
        super.tearDown()
    }

}
