//
//  StatementDateFormatter.swift
//  DesafioIOSTests
//

import XCTest
@testable import DesafioIOS

class StatementDateFormatterTest: XCTestCase {
    

    func testSimpleFormatDisplay() {
        // Given
        let dateToTest = "2021-04-16T10:11:00Z" // 16/04/2021 - 07:11:00
        
        // When
        let simpleFormatDisplay = StatementDateFormatter.shared.simpleFormatDisplay(iso8601String: dateToTest)
        
        // Then
        XCTAssertEqual(simpleFormatDisplay, "16/04")
        
    }
    
    func testCompleteFormatDisplay(){
        // Given
        let dateToTest = "2021-04-16T10:11:00Z" // 16/04/2021 - 07:11:00
        
        // When
        let completeFormatDisplay = StatementDateFormatter.shared.completeFormatDisplay(iso8601String: dateToTest)
        
        // Then
        XCTAssertEqual(completeFormatDisplay, "16/04/2021 - 07:11:00")
    }

    

}
