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
        
        service.getMyStatement(limit: 10, offset: 0) { result in
            switch result {
            case .success(let statement):
                XCTAssertEqual( statement, self.listOfStatement)
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
            
            self.expectation.fulfill()
        }
       
        waitForExpectations(timeout: 1, handler: nil)
        
    }
    
    func test_getMyStatementViewModel_successfulResponse() {
        MockURLProtocol.requestHandler = { request in
            guard let url = request.url, url == self.statementURL, let statementURL = self.statementURL else {
                throw NetWorkResponseError.badRequest
            }
           
            let response = HTTPURLResponse(url: statementURL, statusCode: 200, httpVersion: nil, headerFields: nil)!
            return (response, self.data)
        }
        
        statementViewModel.getStatement { statementViewModel, error in
            XCTAssertEqual( statementViewModel.getAllTransactions(), self.statementViewModel.getAllTransactions())
            XCTAssertNil(error)
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
        
        service.getMyStatement(limit: 10, offset: 0) { result in
            XCTAssertEqual(result, .failure(.decodableDataError))
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
        
        service.getMyStatement(limit: 10, offset: 0) { result in

            XCTAssertEqual(result, .failure(.badRequest))
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
        
        service.getMyStatement(limit: 10, offset: 0) { result in

            XCTAssertEqual(result, .failure(.notFound))
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
        
        service.getMyStatement(limit: 10, offset: 0) { result in

            XCTAssertEqual(result, .failure(.unknownError(statusCode: 500)))
            self.expectation.fulfill()
        }
       
        waitForExpectations(timeout: 1, handler: nil)
        
    }
}
