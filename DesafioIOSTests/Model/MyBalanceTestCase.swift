//
//  MyBalanceTestCase.swift
//  DesafioIOSTests
//
//

import XCTest
@testable import DesafioIOS

class MyBalanceTestCase: XCTestCase {
    
    private let noBreakSpace = "\u{A0}"

    func testStringValueIsFormattedCorrectly(){
        // Given
        let amountOfMoney = 1000.45
        let moneyFormatter = MoneyFormatter.shared
        
        // When
        let myBalance = MyBalance(myBalanceResponse: MyBalanceResponse(amount: amountOfMoney), moneyFormatter: moneyFormatter)
        
        // Then
        XCTAssertEqual(myBalance.value, moneyFormatter.formatMoney(value: amountOfMoney))
    }

}
