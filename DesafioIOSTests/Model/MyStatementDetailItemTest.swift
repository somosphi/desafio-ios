//
//  MyStatementDetailItemTest.swift
//  DesafioIOSTests
//
//

import XCTest
import Combine
@testable import DesafioIOS

class MyStatementDetailItemTest: XCTestCase {
    
    func testInitWithMyStatementDetailResponse(){
        // Given
        let creationDate = Date()
        let statementDetailResponse = MyStatetementDetailResponse(
            id: "some id",
            authentication: "dfqer asdqwer asdf",
            tType: "some type",
            createdAt: ISO8601DateFormatter().string(from: creationDate),
            amount: 500.0,
            to: "someone",
            description: "some description")
        
        // When
        let statementDetail = MyStatementDetail(
            myStatementDetailResponse: statementDetailResponse,
            moneyFormatter: MoneyFormatter.shared,
            statementDateFormatter: StatementDateFormatter.shared)
        
        
        // Then
        
        let expectedResult = MyStatementDetail(
            movementDescription: MyStatementDetailItem(title: "Tipo de movimentação",
                                                       value: statementDetailResponse.description),
            amount: MyStatementDetailItem(title: "Valor",
                                          value: MoneyFormatter.shared.formatMoney(value: statementDetailResponse.amount)) ,
            receiver: MyStatementDetailItem(title: "Recebedor",
                                            value: statementDetailResponse.to),
            createdAt: MyStatementDetailItem(
                title: "Data/Hora",
                value: StatementDateFormatter.shared
                    .completeFormatDisplay(iso8601String: statementDetailResponse.createdAt)),
            authentication: MyStatementDetailItem(title: "Autenticação",
                                                  value: statementDetailResponse.authentication))
        
        XCTAssertEqual(statementDetail, expectedResult)
        XCTAssertEqual(statementDetail.itemsAsList(),
                       [statementDetail.movementDescription,
                        statementDetail.amount,
                        statementDetail.receiver,
                        statementDetail.createdAt,
                        statementDetail.authentication])
        
    }
    
    
    
    
    
    
}
