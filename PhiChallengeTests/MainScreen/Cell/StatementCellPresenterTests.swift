//
//  StatementCellPresenterTests.swift
//  PhiChallengeTests
//
//  Created by Felipe Wilke on 15/11/20.
//

import XCTest

@testable import PhiChallenge

final class StatementCellPresenterTests: XCTestCase {
    
    private let view = StatementCellViewSpy()
    
    func test_attachView_givenDescriptionReceived_shouldDelegateSetAmount() {
        let sut = StatementCellPresenter(statements: Items.fixture(description: "Transferência Realizada"))
        
        sut.attachView(view)
        
        XCTAssertTrue(view.setDescriptionCalled)
        XCTAssertEqual(view.setDescriptionPassed, "Transferência Realizada")
    }
    
    func test_attachView_givenReceiverIsFromReceivedIsNotNil_shouldDelegateSetReceiver() {
        let sut = StatementCellPresenter(statements: Items.fixture(from: "Laura Sacura"))
        
        sut.attachView(view)
        
        XCTAssertTrue(view.setReceiverCalled)
        XCTAssertEqual(view.setReceiverPassed, "Laura Sacura")
    }
    
    func test_attachView_givenReceiverIsFromReceivedIsNil_shouldDelegateSetReceiver() {
        let sut = StatementCellPresenter(statements: Items.fixture(from: nil))
        
        sut.attachView(view)
        
        XCTAssertTrue(view.setReceiverCalled)
        XCTAssertEqual(view.setReceiverPassed, "")
    }
    
    func test_attachView_givenReceiverIsToReceivedIsNil_shouldDelegateSetReceiver() {
        let sut = StatementCellPresenter(statements: Items.fixture(to: nil))
        
        sut.attachView(view)
        
        XCTAssertTrue(view.setReceiverCalled)
        XCTAssertEqual(view.setReceiverPassed, "")
    }
    
    
    func test_attachView_givenAmountReceivedIsNotNil_shouldDelegateSetAmount() {
        
        let sut = StatementCellPresenter(statements: Items.fixture(amount: 1325))
        
        sut.attachView(view)
        
        XCTAssertTrue(view.setAmountCalled)
        XCTAssertEqual(view.setAmountPassed, "R$ 1325,00")
    }
    
    func test_attachView_GivenCreatedAtReceivedIsNotNil_shouldDelegateSetCreatedAtFormatted() {
        let sut = StatementCellPresenter(statements: Items.fixture(createdAt: "2020-11-28T03:00:00Z"))
        
        sut.attachView(view)
        
        XCTAssertTrue(view.setCreatedAtCalled)
        XCTAssertEqual(view.setCreatedAtPassed, "28/11")
    }
    
    func test_attachView_givenPixCashInTransferTypeReceived_shouldDelegateShowPixFlag() {
        let sut = StatementCellPresenter(statements: Items.fixture(tType: "PIXCASHIN"))
        
        sut.attachView(view)
        XCTAssertTrue(view.showPixFlagCalled)
        XCTAssertEqual(view.showPixFlagPassed, true)
    }
    
    func test_attachView_givenPixCashOutTransferTypeReceived_shouldDelegateShowPixFlag() {
        let sut = StatementCellPresenter(statements: Items.fixture(tType: "PIXCASHOUT"))
        
        sut.attachView(view)
        XCTAssertTrue(view.showPixFlagCalled)
        XCTAssertEqual(view.showPixFlagPassed, true)
    }
    
    func test_attachView_givenTransferTypeReceivedIsNil_shouldDelegateShowPixFlag() {
        let sut = StatementCellPresenter(statements: Items.fixture(tType: nil))
        
        sut.attachView(view)
        XCTAssertTrue(view.showPixFlagCalled)
        XCTAssertEqual(view.showPixFlagPassed, false)
        
    }

    
}
