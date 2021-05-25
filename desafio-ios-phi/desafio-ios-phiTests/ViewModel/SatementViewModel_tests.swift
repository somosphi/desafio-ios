//
//  StatementViewModel_tests.swift
//  desafio-ios-phiTests
//
//  Created by Lidiane Gomes on 18/05/21.
//

import XCTest
@testable import desafio_ios_phi

class StatementViewModelTests: XCTestCase {
    var sut: StatementViewModel!
    var balance: Balance!
    var listOfTransactions: [StatementDetailViewModel]!
    
    override func setUp() {
        balance = Balance(amount: 250)
        listOfTransactions = StatementViewModelMockData.shared.listOfTransactions()
        sut = StatementViewModel(balance: balance, listOfTransactions: listOfTransactions)
    
    }

    override func tearDown() {
        balance = nil
        listOfTransactions = nil
        sut = nil
    }

    func test_amount() {
        let expectedResult = "R$ 250,00"
        XCTAssertEqual(sut.amount, expectedResult)
    }
    
    func test_amount_equalNil() {
        sut = StatementViewModel(balance: nil, listOfTransactions: [])
        XCTAssertNil(sut.amount)
    }
    
    func test_function_getAllTransactions() {
        XCTAssertEqual(sut.getAllTransactions(), listOfTransactions)
    }
    
    func test_function_getStatementDetail() {
        let statementDetailTest = StatementDetailViewModel(statement: StatementViewModelMockData
                                                            .shared
                                                            .statementExemple1)
        XCTAssertEqual(sut.getStatementDetail(for: 0), statementDetailTest)
    }
    
    func test_function_getStatementDetail_outOfIndex() {
        XCTAssertNil(sut.getStatementDetail(for: listOfTransactions.count))
    }

}
