//
//  StatementTypeTest.swift
//  DesafioIOSTests
//
//

import XCTest
@testable import DesafioIOS

class StatementTypeTest: XCTestCase {
    
    

    func testStatementResponse_With_TtypeEqualsPixCashIn() {
        // Given
        let statementResponse = createStatementWithTType(tType: PixType.PIXCASHIN.rawValue)
        // When
        let statementType = StatementType.fromMyStatementResponse(statementResponse)
        
        // Then
        XCTAssertEqual(statementType, .PIX)
        
    }
    
    func testStatementResponse_With_TtypeEqualsPixCashOut() {
        // Given
        let statementResponse = createStatementWithTType(tType: PixType.PIXCASHOUT.rawValue)
        // When
        let statementType = StatementType.fromMyStatementResponse(statementResponse)
        
        // Then
        XCTAssertEqual(statementType, .PIX)
        
    }
    
    func testStatementResponse_With_TtypeNotEqualsPix() {
        // Given
        let statementResponse = createStatementWithTType(tType: "otherType")
        // When
        let statementType = StatementType.fromMyStatementResponse(statementResponse)
        
        // Then
        XCTAssertEqual(statementType, .General)
        
    }
    
    
    
    
    private func createStatementWithTType(tType : String) -> MyStatetmentResponse{
        return MyStatetmentResponse(id: "anyId",
                                                     createdAt: "anyData",
                                                     tType: tType,
                                                     amount: 1000,
                                                     to: "someone",
                                                     bankName: "any bank",
                                                     description: "any description")
    }

}
