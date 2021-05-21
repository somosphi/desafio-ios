//
//  StatementDetailNetworkTests.swift
//  desafio-ios-phiTests
//
//  Created by Lidiane Gomes on 20/05/21.
//

import XCTest
@testable import desafio_ios_phi

class StatementDetailNetworkTests: XCTestCase {
    
    var session: URLSession!
    var manager: NetworkManager!
    var service: Service!
    var statement: Statement!
    var expectation: XCTestExpectation!
    var statementDetailURL: URL!
    var data: Data!
    var statementDetailViewModel: StatementDetailViewModel!
    
    override func setUp() {
        let sessionConfiguration = URLSessionConfiguration.default
        sessionConfiguration.protocolClasses = [MockURLProtocol.self]
        session = URLSession(configuration: sessionConfiguration)
        manager = NetworkManager(session: session)
        service = Service(networkManager: manager)
        expectation = expectation(description: "Expectation")
        statement = DataMock.statementDetail
        statementDetailURL = Router.myStatementDetail(transactionID: "49E27207-F3A7-4264-B021-0188690F7D43").url
        data = JsonMock.statementDetail.data(using: .utf8)
        statementDetailViewModel = StatementDetailViewModel(statement: nil, service: service)
    }
    
    override func tearDown() {
        session = nil
        manager = nil
        service = nil
        expectation = nil
        statement = nil
        statementDetailURL = nil
        data = nil
        statementDetailViewModel = nil
    }
    
    func test_getMyStatementDetail_successfulResponse() {
        MockURLProtocol.requestHandler = { _ in
            let response = HTTPURLResponse(url: self.statementDetailURL, statusCode: 200,
                                           httpVersion: nil, headerFields: nil)!
            return (response, self.data)
        }
        
        statementDetailViewModel.get(uuid: "49E27207-F3A7-4264-B021-0188690F7D43") { statement, error  in
            
            XCTAssertNotNil(statement.uuid)
            XCTAssertNotNil(statement.amount)
            XCTAssertNotNil( statement.authentication)
            XCTAssertNotNil( statement.date)
            XCTAssertNil(statement.bankName)
            XCTAssertNotNil( statement.description)
            XCTAssertNotNil( statement.userName)
            XCTAssertNotNil( statement.type)
            XCTAssertNil(error)
        
            self.expectation.fulfill()
        }
       
        waitForExpectations(timeout: 1, handler: nil)
        
    }
    
    func test_getMyStatementDetail_dataIsNil_decodableDataError() {
        MockURLProtocol.requestHandler = { _ in
            let response = HTTPURLResponse(url: self.statementDetailURL, statusCode: 200,
                                           httpVersion: nil, headerFields: nil)!
            return (response, nil)
        }
        
        statementDetailViewModel.get(uuid: "49E27207-F3A7-4264-B021-0188690F7D43") { _, error in
            XCTAssertEqual(error, .decodableDataError)
            self.expectation.fulfill()
        }
       
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func test_getMyStatementDetail_badRequest() {
        MockURLProtocol.requestHandler = { _ in
            let response = HTTPURLResponse(url: self.statementDetailURL, statusCode: 400,
                                           httpVersion: nil, headerFields: nil)!
            return (response, self.data)
        }
        
        statementDetailViewModel.get(uuid: "49E27207-F3A7-4264-B021-0188690F7D43") { _, error in
            XCTAssertEqual( error, .badRequest)
            self.expectation.fulfill()
        }
       
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func test_getMyStatementDetail_notFound() {
        MockURLProtocol.requestHandler = { _ in
            let response = HTTPURLResponse(url: self.statementDetailURL, statusCode: 404,
                                           httpVersion: nil, headerFields: nil)!
            return (response, self.data)
        }
        
        statementDetailViewModel.get(uuid: "49E27207-F3A7-4264-B021-0188690F7D43") { _, error in
            XCTAssertEqual( error, .notFound)
            self.expectation.fulfill()
        }
       
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func test_getMyStatementDetail_unknownError() {
        MockURLProtocol.requestHandler = { _ in
            let response = HTTPURLResponse(url: self.statementDetailURL, statusCode: 500,
                                           httpVersion: nil, headerFields: nil)!
            return (response, self.data)
        }
        
        statementDetailViewModel.get(uuid: "49E27207-F3A7-4264-B021-0188690F7D43") { _, error in
            XCTAssertEqual( error, .unknownError(statusCode: 500))
            self.expectation.fulfill()
        }
       
        waitForExpectations(timeout: 1, handler: nil)
    }
}
