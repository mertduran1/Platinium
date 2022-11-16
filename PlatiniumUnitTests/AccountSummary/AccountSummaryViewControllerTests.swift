//
//  AccountSummaryViewControllerTest.swift
//  PlatiniumUnitTests
//
//  Created by Mert Duran on 15.11.2022.
//

import Foundation
import XCTest

@testable import Platinium

class AccountSummaryViewControllerTests: XCTestCase {
    var vc: AccountSummaryViewController!
    var mockManager: MockProfileManager!
    
    class MockProfileManager: ProfileManagable {
        var profile: Profile?
        var error: NetworkError?
        
        func fetchProfile(forUserId userId: String, completion: @escaping (Result<Platinium.Profile, Platinium.NetworkError>) -> Void) {
            if error != nil {
                completion(.failure(error!))
                return
            }
            profile = Profile(id: "1", firstName: "FirstName", lastName: "LastName")
            completion(.success(profile!))
        }
    }
    override func setUp() {
        super.setUp()
        vc = AccountSummaryViewController()
//        vc.loadViewIfNeeded()
        mockManager = MockProfileManager()
        vc.profileManager = mockManager
    }
    
    func testTitleAndMessageForServerError() throws {
        let titleAndMessage = vc.titleAndMessageForTesting(for: .serverError)
        XCTAssertEqual("Server Error", titleAndMessage.0)
        XCTAssertEqual("Please check your internet connection", titleAndMessage.1)
    }
    
    func testTitleAndMessageForNetworkError() throws {
        let titleAndMessage = vc.titleAndMessageForTesting(for: .decodingError)
        XCTAssertEqual("Decoding error", titleAndMessage.0)
        XCTAssertEqual("We could not process your request. Please try again later", titleAndMessage.1)
    }
    
    func testAlertForServerError() throws {
        mockManager.error = NetworkError.serverError
        vc.forceFetchProfile()
        
        XCTAssertEqual("Server Error", vc.errorAlert.title)
        XCTAssertEqual("Please check your internet connection", vc.errorAlert.message)
    }
    func testAlertForDecodingError() throws {
        mockManager.error = NetworkError.decodingError
        vc.forceFetchProfile()
        
        XCTAssertEqual("Decoding error", vc.errorAlert.title)
        XCTAssertEqual("We could not process your request. Please try again later", vc.errorAlert.message)
    }
}
