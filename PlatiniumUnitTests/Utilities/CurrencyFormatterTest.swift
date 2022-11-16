//
//  CurrencyFormatterTest.swift
//  PlatiniumUnitTests
//
//  Created by Mert Duran on 11.11.2022.
//

import Foundation
import XCTest

@testable import Platinium //Uygulama adi platinium
class Test: XCTestCase {
    var formatter: CurrencyFormatter!
    
    override func setUp() {
        super.setUp()
        formatter = CurrencyFormatter()
    }
    func testBreakLirasIntoKurus() throws {
        let result = formatter.breakIntoLirasAndKurus(123123.23)
        XCTAssertEqual(result.0, "123.123")
        XCTAssertEqual(result.1, "23")
    }
    func testLirasFormatted() throws {
        let result = formatter.lirasFormatted(123123)
        XCTAssertEqual(result, "₺123.123,00")
    }
    func testZeroLirasFormatted() throws {
        let result = formatter.lirasFormatted(0.00)
        XCTAssertEqual(result, "₺0,00")
    }
    
}
