//
//  ReceiptCreatorTests.swift
//  desafio-4allTests
//
//  Created by Vitor Demenighi on 04/01/21.
//

import XCTest
@testable import desafio_4all

class ReceiptCreatorTests: XCTestCase, RequestTestsDataProtocol {
    
    let receiptCreator = ReceiptCreator()
    
    // MARK: - Test Receipt Creator Functions

    func testPageRect() throws {
        XCTAssertEqual(receiptCreator.pageRect, CGRect(x: 0, y: 0, width: 375, height: 562))
    }
    
    func testCreatePDF() throws {
        let statementDetail = try JSONDecoder().decodeWithDate(StatementDetail.self, from: validStatementDetailObject!)
        
        let result = receiptCreator.createPDF(exportValue: statementDetail)
        
        switch result {
        case .success(let pdf):
            XCTAssertFalse(pdf.isEmpty)
            
        case .failure(let error):
            XCTFail(error.localizedDescription)
        }
    }
    
    func testCreateFields() throws {
        let statementDetail = try JSONDecoder().decodeWithDate(StatementDetail.self, from: validStatementDetailObject!)
        receiptCreator.createReceiptFields(statementDetail: statementDetail)
        
        XCTAssertNotNil(receiptCreator.receiptTitle)
        XCTAssertNotNil(receiptCreator.movementType)
        XCTAssertNotNil(receiptCreator.movementValue)
        XCTAssertNotNil(receiptCreator.valueTitle)
        XCTAssertNotNil(receiptCreator.valueText)
        XCTAssertNotNil(receiptCreator.fromTitle)
        XCTAssertNotNil(receiptCreator.fromValue)
        XCTAssertNotNil(receiptCreator.bankNameTitle)
        XCTAssertNotNil(receiptCreator.bankName)
        XCTAssertNotNil(receiptCreator.dateTitle)
        XCTAssertNotNil(receiptCreator.dateValue)
        XCTAssertNotNil(receiptCreator.autenticateTitle)
        XCTAssertNotNil(receiptCreator.autenticateValue)
    }
    
    // MARK: - Test Error Handler
    
    func testFailedCastObject(){
        let genericExportable = MockExportable()
        let result = receiptCreator.createPDF(exportValue: genericExportable)
        
        switch result {
        case .success:
            XCTFail()
            
        case .failure(let error):
            XCTAssertEqual(error.localizedDescription, ErrorConstants.failedCastObject)
        }
    }

}

class MockExportable: Exportable {}
