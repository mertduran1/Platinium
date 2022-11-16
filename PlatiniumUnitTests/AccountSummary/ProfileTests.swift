//
//  ProfileTests.swift
//  PlatiniumUnitTests
//
//  Created by Mert Duran on 14.11.2022.
//

import Foundation
import XCTest

@testable import Platinium //Uygulama adi platinium
class ProfileTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    
    }
    func testCanParse() throws {
        let json = """
    {
    "id": "1",
    "first_name": "Mert",
    "last_name": "Duran",
    }
    """
        
        let data = json.data(using: .utf8)!
        let result = try! JSONDecoder().decode(Profile.self, from: data)
        
        XCTAssertEqual(result.id, "1")
        XCTAssertEqual(result.firstName, "Mert")
        XCTAssertEqual(result.lastName, "Duran")
    }
    
}
