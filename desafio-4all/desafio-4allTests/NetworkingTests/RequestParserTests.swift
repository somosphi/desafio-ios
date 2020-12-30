//
//  RequestParserTests.swift
//  desafio-4allTests
//
//  Created by Vitor Demenighi on 29/12/20.
//

import XCTest
@testable import desafio_4all

class RequestParserTests: XCTestCase, RequestTestsDataProtocol {
    
    let requestParser = RequestParser()
    
    //MARK: - Test Parse Objects
    
    //MARK: Parse Balance Object
    func testParseBalanceObject() throws {
        let result = requestParser.parseData(data: validBalanceObject) as Result<Balance, CustomError>
        
        switch result {
        case .success(let result):  XCTAssertNotNil(result)
        case .failure(let error):   XCTFail(error.localizedDescription)
        }
    }
    
    //MARK: Parse Statement Object
    func testParseStatementObject() throws {
        let result = requestParser.parseData(data: validStatementObject) as Result<Statement, CustomError>
        
        switch result {
        case .success(let result):  XCTAssertNotNil(result)
        case .failure(let error):   XCTFail(error.localizedDescription)
        }
    }
    
    //MARK: Parse StatementDetail Object
    func testStatementDetailObject() throws {
        let result = requestParser.parseData(data: validStatementDetailObject) as Result<StatementDetail, CustomError>
        
        switch result {
        case .success(let result): XCTAssertNotNil(result)
        case .failure(let error):  XCTFail(error.localizedDescription)
        }
    }
    
    //MARK: Parse Empty Statement Items Object
    func testParseEmptyItemsArray() throws {
        let result = requestParser.parseData(data: validEmptyItemsArray) as Result<Statement, CustomError>
        
        switch result {
        case .success(let result):  XCTAssert(result.items.isEmpty)
        case .failure(let error):   XCTFail(error.localizedDescription)
        }
    }
    
    //MARK: - Test Error Handle
    
    //MARK:  Failed to Decode Balance Object
    func testFailedParseInvalidBalanceObject() throws {
        let result = requestParser.parseData(data: invalidBalanceObject) as Result<Balance, CustomError>
        
        switch result {
        case .success: XCTFail()
        case .failure(let error):
            XCTAssertEqual(error.localizedDescription, ErrorConstants.failedToDecode)
        }
    }
    
    //MARK:  Failed to Decode Statement Object
    func testFailedParseInvalidStatementObject() throws {
        let result = requestParser.parseData(data: invalidStatementObject) as Result<Statement, CustomError>
        
        switch result {
        case .success: XCTFail()
        case .failure(let error):
            XCTAssertEqual(error.localizedDescription, ErrorConstants.failedToDecode)
        }
    }
    
    //MARK:  Failed to Decode Statement Detail Object
    func testFailedParseInvalidStatementDetailObject() throws {
        let result = requestParser.parseData(data: invalidStatementDetailObject) as Result<StatementDetail, CustomError>
        
        switch result {
        case .success: XCTFail()
        case .failure(let error):
            XCTAssertEqual(error.localizedDescription, ErrorConstants.failedToDecode)
        }
    }
    
    //MARK:  Response Data Nil
    func testResponseDataIsNil() throws {
        let result = requestParser.parseData(data: nil) as Result<Statement, CustomError>
        
        switch result {
        case .success: XCTFail()
        case .failure(let error):
            XCTAssertEqual(error.localizedDescription, ErrorConstants.responseDataNil)
        }
    }

}
