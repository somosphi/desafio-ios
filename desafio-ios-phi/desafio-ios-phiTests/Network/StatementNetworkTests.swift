//
//  NetWorkManagerTests.swift
//  desafio-ios-phiTests
//
//  Created by Lidiane Gomes on 19/05/21.
//

import XCTest
@testable import desafio_ios_phi

class NetworkManagerTests: XCTestCase {
    
    var session: URLSession!
    var manager: NetworkManager!
    var service: Service!
    var balance: Balance!
    var statement: Statement!
    var listOfStatement: [Statement]!
    var expectation: XCTestExpectation!
    let balanceURL = Router.myBalance.url
    let statementURL = Router.mySatatemet(limit: 0, offset: 0).url
    let statementDetailURL = Router.myStatementDetail(transactionID: "49E27207-F3A7-4264-B021-0188690F7D43").url
    
    override func setUp() {
        let sessionConfiguration = URLSessionConfiguration.default
        sessionConfiguration.protocolClasses = [MockURLProtocol.self]
        session = URLSession(configuration: sessionConfiguration)
        manager = NetworkManager(session: session)
        service = Service(networkManager: manager)
        expectation = expectation(description: "Expectation")
        balance = DataMock.balance
        listOfStatement = DataMock.listOfStatement
        statement = DataMock.statementDetail
    }
    
    override func tearDown() {
        session = nil
        manager = nil
        service = nil
        balance = nil
        expectation = nil
        statement = nil
        listOfStatement = nil
        balance = nil
    }
    
    func test_getMyBalance() {
        let data = JsonMock.balance.data(using: .utf8)
        
        MockURLProtocol.requestHandler = { request in
            guard let url = request.url, url == self.balanceURL, let balanceURL = self.balanceURL else {
                throw NetWorkResponseError.badRequest
            }
           
            let response = HTTPURLResponse(url: balanceURL, statusCode: 200, httpVersion: nil, headerFields: nil)!
            return (response, data)
        }
        
        service.getMyBalance { result in
            switch result {
            case .success(let balance):
                XCTAssertEqual( balance, self.balance)
                    
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
            
            self.expectation.fulfill()
        }
       
        waitForExpectations(timeout: 1, handler: nil)
        
    }
    
    func test_getMyStatement() {
        let data = JsonMock.listOfStatement.data(using: .utf8)
        
        MockURLProtocol.requestHandler = { request in
            guard let url = request.url, url == self.statementURL, let statementURL = self.statementURL else {
                throw NetWorkResponseError.badRequest
            }
           
            let response = HTTPURLResponse(url: statementURL, statusCode: 200, httpVersion: nil, headerFields: nil)!
            return (response, data)
        }
        
        service.getMyStatement(limit: 0, offset: 0) { result in
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
    
    func test_getMyStatementDetail() {
        let data = JsonMock.statementDetail.data(using: .utf8)
        
        MockURLProtocol.requestHandler = { request in
            guard let url = request.url, url == self.statementDetailURL,
                  let statementURL = self.statementDetailURL else {
                throw NetWorkResponseError.badRequest
            }
           
            let response = HTTPURLResponse(url: statementURL, statusCode: 200, httpVersion: nil, headerFields: nil)!
            return (response, data)
        }
        
        service.getMyStatementDetail(transactionID: "49E27207-F3A7-4264-B021-0188690F7D43") { result in
            switch result {
            case .success(let statement):
                XCTAssertEqual( statement?.uuid, self.statement.uuid)
                XCTAssertEqual( statement?.amount, self.statement.amount)
                XCTAssertEqual( statement?.authentication, self.statement.authentication)
                XCTAssertEqual( statement?.date, self.statement.date)
                XCTAssertEqual( statement?.bankName, self.statement.bankName)
                XCTAssertEqual( statement?.description, self.statement.description)
                XCTAssertEqual( statement?.from, self.statement.from)
                XCTAssertEqual( statement?.sentTo, self.statement.sentTo)
                XCTAssertEqual( statement?.type, self.statement.type)
                
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
            
            self.expectation.fulfill()
        }
       
        waitForExpectations(timeout: 1, handler: nil)
        
    }
}
