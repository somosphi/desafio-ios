//
//  StatementNetworkTests.swift
//  desafio-ios-phiTests
//
//  Created by Lidiane Gomes on 19/05/21.
//

import XCTest
@testable import desafio_ios_phi

class StatementNetworkTests: XCTestCase {
    
    var session: URLSession!
    var manager: NetworkManager!
    var service: Service!
    var listOfStatement: [Statement]!
    var statementViewModel: StatementViewModel!
    var expectation: XCTestExpectation!
    var statementURL: URL!
    var data: Data!
  
    override func setUp() {
        let sessionConfiguration = URLSessionConfiguration.default
        sessionConfiguration.protocolClasses = [MockURLProtocol.self]
        session = URLSession(configuration: sessionConfiguration)
        manager = NetworkManager(session: session)
        service = Service(networkManager: manager)
        expectation = expectation(description: "Expectation")
        listOfStatement = DataMock.listOfStatement
        statementViewModel = StatementViewModel(service: service)
        statementURL = Router.mySatatemet(limit: 10, offset: 0).url
        data = JsonMock.listOfStatement.data(using: .utf8)
    }
    
    override func tearDown() {
        session = nil
        manager = nil
        service = nil
        expectation = nil
        listOfStatement = nil
        statementViewModel = nil
        statementURL = nil
        data = nil
    }
    
    func test_getMyStatement_successfulResponse() {
        MockURLProtocol.requestHandler = { _ in
            let response = HTTPURLResponse(url: self.statementURL, statusCode: 200,
                                           httpVersion: nil, headerFields: nil)!
            return (response, self.data)
        }
        
        statementViewModel.getStatement { statementViewModel, error in
            XCTAssertEqual( statementViewModel.getAllTransactions(), self.statementViewModel.getAllTransactions())
            XCTAssertNil(error)
            self.expectation.fulfill()
        }
       
        waitForExpectations(timeout: 1, handler: nil)
        
    }
    
    func test_getMyStatementPagination_successfulResponse() {
        MockURLProtocol.requestHandler = { _ in
            let response = HTTPURLResponse(url: self.statementURL, statusCode: 200,
                                           httpVersion: nil, headerFields: nil)!
            return (response, self.data)
        }
        
        statementViewModel.getStatementWithPagination { statementViewModel, newStatements in
            XCTAssertEqual( statementViewModel, self.statementViewModel)
            XCTAssertEqual(newStatements, self.statementViewModel.getAllTransactions())
            self.expectation.fulfill()
        }
       
        waitForExpectations(timeout: 1, handler: nil)
        
    }
    
    func test_getMyStatement_dataIsNil_decodableDataError() {
        MockURLProtocol.requestHandler = { _ in
            let response = HTTPURLResponse(url: self.statementURL, statusCode: 200,
                                           httpVersion: nil, headerFields: nil)!
            return (response, nil)
        }
        
        statementViewModel.getStatement { _, error in
            XCTAssertEqual(error, .decodableDataError)
            self.expectation.fulfill()
        }
       
        waitForExpectations(timeout: 1, handler: nil)
        
    }
    
    func test_getMyStatementPagination_decodableDataError() {
        MockURLProtocol.requestHandler = { _ in
            let response = HTTPURLResponse(url: self.statementURL, statusCode: 200,
                                           httpVersion: nil, headerFields: nil)!
            return (response, nil)
        }
        
        statementViewModel.getStatementWithPagination { _, newStatements in
            XCTAssertEqual(newStatements, [])
            self.expectation.fulfill()
        }
       
        waitForExpectations(timeout: 1, handler: nil)
        
    }
    
    func test_getMyStatement_badRequest() {
        MockURLProtocol.requestHandler = { _ in
            
            let response = HTTPURLResponse(url: self.statementURL, statusCode: 400,
                                           httpVersion: nil, headerFields: nil)!
            return (response, self.data)
        }
        
        statementViewModel.getStatement { _, error in

            XCTAssertEqual(error, .badRequest)
            self.expectation.fulfill()
        }
       
        waitForExpectations(timeout: 1, handler: nil)
        
    }
    
    func test_getMyStatementPagination_badRequest() {
        MockURLProtocol.requestHandler = { _ in
            let response = HTTPURLResponse(url: self.statementURL, statusCode: 400,
                                           httpVersion: nil, headerFields: nil)!
            return (response, self.data)
        }
        
        statementViewModel.getStatementWithPagination { _, newStatements in
            XCTAssertEqual(newStatements, [])
            self.expectation.fulfill()
        }
       
        waitForExpectations(timeout: 1, handler: nil)
        
    }
    
    func test_getMyStatement_notFound() {
        MockURLProtocol.requestHandler = { _ in
            let response = HTTPURLResponse(url: self.statementURL, statusCode: 404,
                                           httpVersion: nil, headerFields: nil)!
            return (response, self.data)
        }
        
        statementViewModel.getStatement { _, error in

            XCTAssertEqual(error, .notFound)
            self.expectation.fulfill()
        }
       
        waitForExpectations(timeout: 1, handler: nil)
        
    }
    
    func test_getMyStatementPagination_notFound() {
        MockURLProtocol.requestHandler = { _ in
            let response = HTTPURLResponse(url: self.statementURL, statusCode: 404,
                                           httpVersion: nil, headerFields: nil)!
            return (response, self.data)
        }
        
        statementViewModel.getStatementWithPagination { _, newStatements in
            XCTAssertEqual(newStatements, [])
            self.expectation.fulfill()
        }
       
        waitForExpectations(timeout: 1, handler: nil)
        
    }
    
    func test_getMyStatement_unknownError() {
        MockURLProtocol.requestHandler = { _ in
            let response = HTTPURLResponse(url: self.statementURL, statusCode: 500,
                                           httpVersion: nil, headerFields: nil)!
            return (response, self.data)
        }
        
        statementViewModel.getStatement { _, error in

            XCTAssertEqual(error, .unknownError(statusCode: 500))
            self.expectation.fulfill()
        }
       
        waitForExpectations(timeout: 1, handler: nil)
        
    }
    
    func test_getMyStatementPagination_unknwonError() {
        MockURLProtocol.requestHandler = { _ in
            let response = HTTPURLResponse(url: self.statementURL, statusCode: 500,
                                           httpVersion: nil, headerFields: nil)!
            return (response, self.data)
        }
        
        statementViewModel.getStatementWithPagination { _, newStatements in
            XCTAssertEqual(newStatements, [])
            self.expectation.fulfill()
        }
       
        waitForExpectations(timeout: 1, handler: nil)
        
    }
}
