//
//  BalanceHeaderPresenterTests.swift
//  PhiChallengeTests
//
//  Created by Felipe Wilke on 15/11/20.
//

import XCTest

@testable import PhiChallenge

final class BalanceHeaderPresenterTests: XCTestCase {
    
    private let view = BalanceHeaderViewSpy()
    
    func test_attachView_givenAmountReceived_shouldDelegateSetAmount() {
        let sut = BalanceHeaderPresenter(balance: 1325)
        
        sut.attachView(view)
        
        XCTAssertTrue(view.setAmountCalled)
        XCTAssertEqual(view.setAmountPassed, "R$ 1325,00")
    }
    
    func test_shouldHideAmount_givenEyeButtonDidTap_shouldDelegateShouldHideAmount() {
        let sut = BalanceHeaderPresenter(balance: 1325)
        sut.attachView(view)
        
        sut.shouldHideAmount()
        
        XCTAssertTrue(view.hideAmountCalled)
        XCTAssertEqual(view.hideAmountFlagPassed, true)
        XCTAssertEqual(view.hideAmountImagePassed, "show-eye")
    }
    
    func test_shouldHideAmount_givenEyeButtonDidTapTwice_shouldDelegateShouldHideAmount() {
        let sut = BalanceHeaderPresenter(balance: 1325)
        sut.attachView(view)
        
        sut.shouldHideAmount()
        
        XCTAssertTrue(view.hideAmountCalled)
        XCTAssertEqual(view.hideAmountFlagPassed, false)
        XCTAssertEqual(view.hideAmountImagePassed, "hide-eye")
    }
}



