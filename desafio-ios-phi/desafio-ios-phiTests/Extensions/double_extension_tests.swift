//
//  double_extension_tests.swift
//  desafio-ios-phiTests
//
//  Created by Lidiane Gomes on 18/05/21.
//

import XCTest
import desafio_ios_phi

class DoubleExtensionTests: XCTestCase {
    var largeNumber: Double!
    var shortNumber: Double!
    
    override func setUp() {
        largeNumber = 2458487.24584
        shortNumber = 0.7
    }

    override func tearDown() {
        largeNumber = nil
    }

    func test_largeNumber_correctFormatter() {
        let result = "2.458.487,25"
        let numberToTest = largeNumber.formattedWithSeparator
        XCTAssertEqual(numberToTest, result)
    }
    
    func test_shortNumber_correctFormatter() {
        let result = "0,70"
        let numberToTest = shortNumber.formattedWithSeparator
        XCTAssertEqual(numberToTest, result)
    }
    
    func test_numberIsNil() {
        let nilNumber: Double? = nil
        let numberToTest = nilNumber?.formattedWithSeparator
        XCTAssertNil(numberToTest)
    }
}
