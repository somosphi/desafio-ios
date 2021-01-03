//
//  StatementDetailViewModelTests.swift
//  desafio-4allTests
//
//  Created by Vitor Demenighi on 03/01/21.
//

import XCTest
@testable import desafio_4all

class StatementDetailViewModelTests: XCTestCase, RequestTestsDataProtocol {
    
    // MARK: - Environment Variables
    
    var session: NetworkSessionMock?
    var requestCaller: RequestCaller?
    var network: NetworkWorker?
    var viewModel: StatementDetailViewModel?
    
    // MARK: - Result Variables
    
    var expectation: XCTestExpectation?
    
    var resultStatementDetail: StatementDetail?
    
    var getStatementDetailResult: Bool?
    var failedResult: Bool?
    var message: String?

    // MARK: - Setup
    
    override func setUp() {
        session = NetworkSessionMock()
        requestCaller = RequestCaller(session: session!)
        network = NetworkWorker(requestCaller: requestCaller!)
        viewModel = StatementDetailViewModel(network: network!, delegate: self, statementId: testID)
    }
    
    // MARK: - Test StatementDetailViewModel Functions
    
    // MARK: getStatementDetail
    func testGetStatementDetail() throws {
        expectation = expectation(description: "Get statement detail succeed")
        
        session!.statusCode = 200
        session!.data = validStatementDetailObject
        
        viewModel?.getStatementDetail()
        
        waitForExpectations(timeout: 1)
        
        let resultDecode = try JSONDecoder().decodeWithDate(StatementDetail.self, from: validStatementDetailObject!)
        
        XCTAssertEqual(getStatementDetailResult, true)
        XCTAssertEqual(resultStatementDetail, resultDecode)
    }
    
    // MARK: - Test Error Handler
    
    // MARK: - getStatementDetail failed with error 500
    func testGetStatementDetailFailed() throws {
        expectation = expectation(description: "Get statement detail succeed")
        
        session!.statusCode = 500
        
        viewModel?.getStatementDetail()
         
        waitForExpectations(timeout: 1)
        
        XCTAssertEqual(failedResult, true)
        XCTAssertEqual(message, CustomError.serverError(500).localizedDescription)
    }
    
}

//MARK: - StatementDetailViewModel Delegate

extension StatementDetailViewModelTests: StatementDetailViewModelDelegate {
    func didGetStatementDetail(statementDetail: StatementDetail) {
        if expectation != nil {
            self.getStatementDetailResult = true
            self.resultStatementDetail = statementDetail
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
