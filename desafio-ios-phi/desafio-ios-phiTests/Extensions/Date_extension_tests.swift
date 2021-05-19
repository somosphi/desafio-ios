//
//  Date_extension_tests.swift
//  desafio-ios-phiTests
//
//  Created by Lidiane Gomes on 18/05/21.
//

import XCTest
@testable import desafio_ios_phi

class DateExtensionTests: XCTestCase {
    var dateToTest: Date!

    override func setUp() {
        // "2021-05-18T15:05:31Z"
        dateToTest = Date(timeIntervalSinceReferenceDate: 643055131)
    }

    override func tearDown() {
        dateToTest = nil
    }

    func test_dateToString() {
        let result = "18/05/2021 - 15:05:31"
        XCTAssertEqual(dateToTest.toString, result)
    }
    
    func test_dateToShortString() {
        let result = "18/05"
        XCTAssertEqual(dateToTest.toShortString, result)
    }
}
