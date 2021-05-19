//
//  StatementDetailViewModel_tests.swift
//  desafio-ios-phiTests
//
//  Created by Lidiane Gomes on 19/05/21.
//

import XCTest
@testable import desafio_ios_phi

class StatementDetailViewModelTests: XCTestCase {
    
    var sut: StatementDetailViewModel!
    
    override func setUp() {
        sut = StatementDetailViewModel(statement: StatementViewModelMockData.shared.statementExemple1)
    }

    override func tearDown() {
        sut = nil
    }

    func test_propertiesInicializationOne_notNilValues() {
        XCTAssertNotNil(sut.amount)
        XCTAssertNotNil(sut.authentication)
        XCTAssertNotNil(sut.bankName)
        XCTAssertNotNil(sut.date)
        XCTAssertNotNil(sut.dateResume)
        XCTAssertNotNil(sut.userName)
        XCTAssertNotNil(sut.uuid)
        XCTAssertNotNil(sut.description)
        XCTAssertNotNil(sut.type)
    }
    
    func test_propertiesInicializationTwo_notNilValues() {
        sut = StatementDetailViewModel(statement: StatementViewModelMockData.shared.statementExemple2)
        XCTAssertNotNil(sut.amount)
        XCTAssertNotNil(sut.authentication)
        XCTAssertNotNil(sut.bankName)
        XCTAssertNotNil(sut.date)
        XCTAssertNotNil(sut.dateResume)
        XCTAssertNotNil(sut.userName)
        XCTAssertNotNil(sut.uuid)
        XCTAssertNotNil(sut.description)
        XCTAssertNotNil(sut.type)
    }
    
    func test_propertiesInicialization_nilValues() {
        sut = StatementDetailViewModel(statement: StatementViewModelMockData.shared.statementNilExemple)
        XCTAssertNil(sut.amount)
        XCTAssertNil(sut.authentication)
        XCTAssertNil(sut.bankName)
        XCTAssertNil(sut.date)
        XCTAssertNil(sut.dateResume)
        XCTAssertNil(sut.userName)
        XCTAssertNotNil(sut.uuid)
        XCTAssertNil(sut.description)
        XCTAssertNil(sut.type)
    }
}
