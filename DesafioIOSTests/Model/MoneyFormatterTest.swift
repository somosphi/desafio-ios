//
//  MoneyFormatterTest.swift
//  DesafioIOSTests
//
//

import XCTest
@testable import DesafioIOS

class MoneyFormatterTest: XCTestCase {
    
    private let noBreakSpace = "\u{A0}"
    
    func testFormatPositiveMoney(){
        // Given
        let money = 1000.347
        
        // When
        let moneyToString = MoneyFormatter.shared.formatMoney(value : money)
        
        // Then
        XCTAssertEqual(moneyToString, "R$\(noBreakSpace)1.000,35")
    }

    func testFormatNegativeMoney(){
        // Given
        let money = -1000.347
        
        // When
        let moneyToString = MoneyFormatter.shared.formatMoney(value : money)
        
        // Then
        XCTAssertEqual(moneyToString, "-R$\(noBreakSpace)1.000,35")
    }
    
}
