//
//  HomeViewModelTests.swift
//  desafio-4allTests
//
//  Created by Vitor Demenighi on 03/01/21.
//

import XCTest
@testable import desafio_4all

class HomeViewModelTests: XCTestCase, RequestTestsDataProtocol {
    
    // MARK: - Environment Variables

    var session: NetworkSessionMock?
    var requestCaller: RequestCaller?
    var network: NetworkWorker?
    var viewModel: HomeViewModel?
    
    // MARK: - Result Variables
    
    var expectation: XCTestExpectation?
    
    var resultBalance: Balance?
    var resultStatement: Statement?
    
    var getMyBalanceResult: Bool?
    var getStatementResult: Bool?
    var failedResult: Bool?
    var message: String?
    
    // MARK: - Setup
    
    override func setUp() {
        session = NetworkSessionMock()
        requestCaller = RequestCaller(session: session!)
        network = NetworkWorker(requestCaller: requestCaller!)
        viewModel = HomeViewModel(network: network!, delegate: self)
    }
    
    // MARK: - Test HomeViewModel Functions

    // MARK: getMyBalance
    func testGetMyBalance() throws {
        expectation = expectation(description: "Get my balance succeed")
        
        session!.statusCode = 200
        session!.data = validBalanceObject
        
        viewModel?.getMyBalance()
        
        waitForExpectations(timeout: 1)
        
        let resultDecode = try JSONDecoder().decode(Balance.self, from: validBalanceObject!)
        
        XCTAssertEqual(getMyBalanceResult, true)
        XCTAssertEqual(resultBalance?.amount, resultDecode.amount)
    }
    
    // MARK: getStatement
    func testGetStatement() throws {
        expectation = expectation(description: "Get statement succeed")
        
        session!.statusCode = 200
        session!.data = validStatementObject
        
        viewModel?.getMyStatement(page: 1)
        
        waitForExpectations(timeout: 1)
        
        XCTAssertEqual(getStatementResult, true)
        XCTAssertFalse(viewModel!.items.isEmpty)
    }
    
    // MARK: - Test Error Handle
    
    // MARK: getMyBalance failed with error code 400
    func testGetMyBalanceFailed() throws {
        expectation = expectation(description: "Get my balance failed")
        
        session!.statusCode = 400
        
        viewModel?.getMyBalance()
        
        waitForExpectations(timeout: 1)
        
        XCTAssertEqual(failedResult, true)
        XCTAssertEqual(message, CustomError.clientError(400).localizedDescription)
    }
    
    // MARK: getStatement failed with data nil
    func testGetStatementFailed() throws {
        expectation = expectation(description: "Get statement failed")
        
        session!.statusCode = 200
        session!.data = nil
        
        viewModel?.getMyStatement(page: 1)
        
        waitForExpectations(timeout: 1)
        
        XCTAssertEqual(failedResult, true)
        XCTAssertEqual(message, CustomError.responseDataNil.localizedDescription)
    }
}

// MARK: - HomeViewModel Delegate

extension HomeViewModelTests: HomeViewModelDelegate {
    func didGetStatement() {
        if expectation != nil {
            self.getStatementResult = true
        }
        expectation?.fulfill()
        expectation = nil
    }
    
    func didGetBalance(balance: Balance) {
        if expectation != nil {
            self.getMyBalanceResult = true
            self.resultBalance = balance
        }
        expectation?.fulfill()
        expectation = nil
    }
    
    func failed(message: String) {
        if expectation != nil {
            self.failedResult = true
            self.message = message
        }
        expectation?.fulfill()
        expectation = nil
    }
}
