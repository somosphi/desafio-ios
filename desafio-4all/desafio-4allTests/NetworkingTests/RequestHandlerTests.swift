//
//  RequestHandlerTests.swift
//  desafio-4allTests
//
//  Created by Vitor Demenighi on 29/12/20.
//

import XCTest
@testable import desafio_4all

class RequestHandlerTests: XCTestCase, RequestTestsDataProtocol {
    
    let requestHandler = RequestHandler()
    
    //MARK:- Test Requests Handler
    
    //MARK: myBalance Request Handler
    func testMyBalanceRequestHandler() throws {
        let endpoint = Endpoint.myBalance
        let result = requestHandler.makeRequest(endPoint: endpoint, parameters: nil)
        
        switch result {
        case .success(let result):
            XCTAssertEqual(result.url?.absoluteString, endpoint.completePath)
            XCTAssertEqual(result.httpMethod, endpoint.parameters.method.rawValue)
            XCTAssert(result.containsToken())
            
        case .failure(let error): XCTFail(error.localizedDescription)
        }
    }

    //MARK: myStatement Request Handler
    func testMyStatementRequestHandler() throws {
        let endpoint = Endpoint.myStatement(offset: 1)
        let result = requestHandler.makeRequest(endPoint: endpoint, parameters: nil)
        
        switch result {
        case .success(let result):
            XCTAssertEqual(result.url?.absoluteString, endpoint.completePath)
            XCTAssertEqual(result.httpMethod, endpoint.parameters.method.rawValue)
            XCTAssert(result.containsToken())
            
        case .failure(let error): XCTFail(error.localizedDescription)
        }
    }
    
    //MARK: statmentDetail Request Handler
    func testStatementDetailRequestHandler() throws {
        let endpoint = Endpoint.statementDetail(id: testID)
        let result = requestHandler.makeRequest(endPoint: endpoint, parameters: nil)
        
        switch result {
        case .success(let result):
            XCTAssertEqual(result.url?.absoluteString, endpoint.completePath)
            XCTAssertEqual(result.httpMethod, endpoint.parameters.method.rawValue)
            XCTAssert(result.containsToken())
            
        case .failure(let error): XCTFail(error.localizedDescription)
        }
    }
    
    //MARK: statmentDetail Request Handler with Parameters
    func testStatementDetailRequestHandlerWithParameters() throws {
        let parameters = ["id": 1]
        let endpoint = Endpoint.statementDetail(id: testID)
        let result = requestHandler.makeRequest(endPoint: endpoint, parameters: parameters)
        
        switch result {
        case .success(let result):
            XCTAssertEqual(result.url?.absoluteString, endpoint.completePath)
            XCTAssertEqual(result.httpMethod, endpoint.parameters.method.rawValue)
            XCTAssert(result.containsToken())
            XCTAssertNotNil(result.httpBody)
            
        case .failure(let error): XCTFail(error.localizedDescription)
        }
    }
   
    //MARK:- Test Error Handler
    
    //MARK: Invalid URL Error Handler
    func testInvalidURLError() throws {
        let result = requestHandler.makeRequest(endPoint: .invalidPath, parameters: nil)
        
        switch result {
        case .success:  XCTFail()
        case .failure(let error):
            let customError = error as! CustomError
            XCTAssertEqual(customError.localizedDescription, ErrorConstants.invalidURL)
        }
    }
    
    //MARK: Handler Request Without Token
    func testHandlerRequestWithoutToken() throws {
        
        let result = requestHandler.makeRequest(endPoint: .withoutToken, parameters: nil)
        
        switch result {
        case .success(let request): XCTAssertFalse(request.containsToken())
        case .failure(let error):   XCTFail(error.localizedDescription)
        }
    }
}
