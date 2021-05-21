//
//  BalanceNewtorkTests.swift
//  desafio-ios-phiTests
//
//  Created by Lidiane Gomes on 20/05/21.
//

import XCTest
@testable import desafio_ios_phi

class BalanceNetWorkTests: XCTestCase {
    
    var session: URLSession!
    var manager: NetworkManager!
    var service: Service!
    var balance: Balance!
    var statementViewModel: StatementViewModel!
    var expectation: XCTestExpectation!
    var balanceURL: URL!
    var data: Data!
    
    override func setUp() {
        let sessionConfiguration = URLSessionConfiguration.default
        sessionConfiguration.protocolClasses = [MockURLProtocol.self]
        session = URLSession(configuration: sessionConfiguration)
        manager = NetworkManager(session: session)
        service = Service(networkManager: manager)
        statementViewModel = StatementViewModel(service: service)
        expectation = expectation(description: "Expectation")
        balance = DataMock.balance
        balanceURL = Router.myBalance.url
        data = JsonMock.balance.data(using: .utf8)
    }
    
    override func tearDown() {
        session = nil
        manager = nil
        service = nil
        balance = nil
        expectation = nil
        balance = nil
        balanceURL = nil
        data = nil
    }
    
    func test_getMyBalance_successfulResponse() {
        MockURLProtocol.requestHandler = { _ in
            let response = HTTPURLResponse(url: self.balanceURL, statusCode: 200, httpVersion: nil, headerFields: nil)!
            return (response, self.data)
        }
        
        statementViewModel.getMyBalance { statementViewModel, error in
            XCTAssertEqual(statementViewModel.amount, self.balance.amount?.formattedWithSeparator)
            XCTAssertNil(error)
            self.expectation.fulfill()
        }
       
        waitForExpectations(timeout: 1, handler: nil)
        
    }
    
    func test_getMyBalance_dataIsNil() {
        MockURLProtocol.requestHandler = { _ in
            let response = HTTPURLResponse(url: self.balanceURL, statusCode: 200,
                                           httpVersion: nil, headerFields: nil)!
            return (response, nil)
        }
        
        service.getMyBalance { result in
            XCTAssertEqual(result, .success(nil))
            self.expectation.fulfill()
        }
       
        waitForExpectations(timeout: 1, handler: nil)
        
    }
    
    func test_getMyBalance_badRequest() {
        MockURLProtocol.requestHandler = { _ in
            let response = HTTPURLResponse(url: self.balanceURL, statusCode: 400, httpVersion: nil, headerFields: nil)!
            return (response, self.data)
        }
        
        statementViewModel.getMyBalance { _, error in
            XCTAssertEqual( error, .badRequest)
            self.expectation.fulfill()
        }
       
        waitForExpectations(timeout: 1, handler: nil)
        
    }
    
    func test_getMyBalance_notFound() {
        MockURLProtocol.requestHandler = { _ in
            let response = HTTPURLResponse(url: self.balanceURL, statusCode: 404, httpVersion: nil, headerFields: nil)!
            return (response, self.data)
        }
        
        statementViewModel.getMyBalance { _, error in
            XCTAssertEqual( error, .notFound)
            self.expectation.fulfill()
        }
       
        waitForExpectations(timeout: 1, handler: nil)
        
    }
    
    func test_getMyBalance_unknownError() {
        MockURLProtocol.requestHandler = { _ in
            let response = HTTPURLResponse(url: self.balanceURL, statusCode: 500, httpVersion: nil, headerFields: nil)!
            return (response, self.data)
        }
        
        statementViewModel.getMyBalance { _, error in
            XCTAssertEqual( error, .unknownError(statusCode: 500))
            self.expectation.fulfill()
        }
       
        waitForExpectations(timeout: 1, handler: nil)
        
    }
}
