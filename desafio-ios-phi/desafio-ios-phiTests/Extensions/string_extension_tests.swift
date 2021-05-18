//
//  string_extension_tests.swift
//  desafio-ios-phiTests
//
//  Created by Lidiane Gomes on 18/05/21.
//

import XCTest
@testable import desafio_ios_phi

class StringExtensionTests: XCTestCase {
    var correctStringDate: String!
    var invalidStringDate: String!
    
    override func setUp() {
        correctStringDate = "2021-05-18T18:25:31Z"
        invalidStringDate = "2021-17-22T00:00:00Z"
    }

    override func tearDown() {
        correctStringDate = nil
        invalidStringDate = nil
    }

    func test_correctStringDate() {
        let result = Date(timeIntervalSinceReferenceDate: 643055131)
        XCTAssertEqual(correctStringDate.toDate, result)
    }
    
    func test_invalidStringDate_isNil() {
        XCTAssertNil(invalidStringDate.toDate)
    }
}
