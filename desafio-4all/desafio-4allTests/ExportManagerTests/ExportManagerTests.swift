//
//  ExportManagerTests.swift
//  desafio-4allTests
//
//  Created by Vitor Demenighi on 04/01/21.
//

import XCTest
@testable import desafio_4all

class ExportManagerTests: XCTestCase, RequestTestsDataProtocol {
    
    let exportManager = ExportManager(pdfCreator: ReceiptCreator())
    
    // MARK: - Test Export Manager Functions

    func testGetImage() throws {
        let statementDetail = try JSONDecoder().decodeWithDate(StatementDetail.self, from: validStatementDetailObject!)
        
        let result = exportManager.getImage(exportValue: statementDetail)
        
        switch result {
        case .success(let image):
            XCTAssertEqual(image.accessibilityIdentifier, "ExportImage")
            
        case .failure(let error):
            XCTFail(error.localizedDescription)
        }
    }
    
    func testGetPDF() throws {
        let statementDetail = try JSONDecoder().decodeWithDate(StatementDetail.self, from: validStatementDetailObject!)
        
        let result = exportManager.getPdfURL(exportValue: statementDetail)
        
        switch result {
        case .success(let url):
            XCTAssertFalse(url.absoluteString.isEmpty)
        case .failure(let error):
            XCTFail(error.localizedDescription)
        }
    }
    
    // MARK: - Test Error Handler
    
    func testCastObjectImage() throws {
        let genericExportable = MockExportable()
        
        let result = exportManager.getImage(exportValue: genericExportable)
        
        switch result {
        case .success:
            XCTFail()
            
        case .failure(let error):
            XCTAssertEqual(error.localizedDescription, ErrorConstants.failedCastObject)
        }
    }
    
    func testCastObjectPDF() throws {
        let genericExportable = MockExportable()
        
        let result = exportManager.getPdfURL(exportValue: genericExportable)
        
        switch result {
        case .success:
            XCTFail()
            
        case .failure(let error):
            XCTAssertEqual(error.localizedDescription, ErrorConstants.failedCastObject)
        }
    }
}
