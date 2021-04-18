//
//  MyStatementItemTest.swift
//  DesafioIOSTests
//
//

import XCTest
@testable import DesafioIOS

class MyStatementItemTest: XCTestCase {

    func testInitUsingStatementResponse(){
        // Given
        let date = Date()
        let statementResponse = MyStatetmentResponse(
            id: "id",
            createdAt: ISO8601DateFormatter().string(from: date),
            tType: PixType.PIXCASHIN.rawValue,
            amount: 100,
            to: "someone",
            bankName: "bank name",
            description: "statement description")
        
        // When
        let myStatementCellViewModel = MyStatementItem(
            statementResponse: statementResponse,
            statementDateFormatter: StatementDateFormatter.shared,
            moneyFormatter: MoneyFormatter.shared)
        
        // Then
        let expectedResult = MyStatementItem(
            id: statementResponse.id,
            type: StatementType.PIX,
            description: statementResponse.description,
            creationDate: StatementDateFormatter.shared
                .simpleFormatDisplay(iso8601String: statementResponse.createdAt),
            destination: statementResponse.to!,
            amountOfMoney: MoneyFormatter.shared.formatMoney(value: 100))
        
        XCTAssertEqual(expectedResult, myStatementCellViewModel)
        
    }

}
