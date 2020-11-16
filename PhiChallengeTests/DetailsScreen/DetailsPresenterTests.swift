//
//  DetailsPresenterTests.swift
//  PhiChallengeTests
//
//  Created by Felipe Wilke on 16/11/20.
//

import XCTest

@testable import PhiChallenge

class DetailsScreenPresenterTests: XCTestCase {

    private let view = DetailsScreenViewSpy()
    private let service = DetailsServiceSpy()
    private lazy var sut = DetailsPresenter(id: "0B5BFD44-0DF1-4005-A7CF-66C9C0438380", service: service)
    
    override func setUp() {
        sut.view = view
    }

    func test_viewDidLoad_shouldFetchStatementIdAndDelegateShowLoader() {
        sut.viewDidLoad()
        
        XCTAssertTrue(service.fetchStatementIDCalled)
        XCTAssertEqual(service.fetchStatementIDPassed, "0B5BFD44-0DF1-4005-A7CF-66C9C0438380")
        XCTAssertTrue(view.showLoaderCalled)
    }
    
    func test_tryAgain_shouldFetchStatementIdAndDelegateShowLoader() {
        sut.tryAgain()
        
        XCTAssertTrue(service.fetchStatementIDCalled)
        XCTAssertEqual(service.fetchStatementIDPassed, "0B5BFD44-0DF1-4005-A7CF-66C9C0438380")
        XCTAssertTrue(view.showLoaderCalled)
    }
    
    func test_didUpdateDetailsSucess_givenDescriptionDataReceived_shouldDelegateSetDescription() {
        sut.didUpdateDetailsSuccess(Items.fixture(description: "Transferência Realizada"))
        
        XCTAssertTrue(view.setDescriptionCalled)
        XCTAssertEqual(view.setDescriptionPassed, "Transferência Realizada")
    }
    
    func test_didUpdateDetailSuccess_givenDataReceived_shouldDelegateSetAmount() {
        sut.didUpdateDetailsSuccess(Items.fixture(amount: 1384))
        
        XCTAssertTrue(view.setAmountCalled)
        XCTAssertEqual(view.setAmountPassed, "R$ 1384,00")
    }
    
    func test_didUpdateDetailSuccess_givenFromReceiverDataReceivedIsNotNil_shouldDelegateSetReceiver() {
        sut.didUpdateDetailsSuccess(Items.fixture(from: "Laura Sacura"))
        
        XCTAssertTrue(view.setReceiverCalled)
        XCTAssertEqual(view.setReceiverPassed, "Laura Sacura")
    }
    
    func test_didUpdateDetailSuccess_givenFromReceiverDataReceivedIsNil_shouldDelegateSetReceiver() {
        sut.didUpdateDetailsSuccess(Items.fixture(from: nil))
        
        XCTAssertTrue(view.setReceiverCalled)
        XCTAssertEqual(view.setReceiverPassed, "")
    }
    
    func test_didUpdateDetailSuccess_givenToReiceverDataReceivedIsNil_shouldDelegateSetReceiver() {
        sut.didUpdateDetailsSuccess(Items.fixture(to: nil))
        
        XCTAssertTrue(view.setReceiverCalled)
        XCTAssertEqual(view.setReceiverPassed, "")
    }
    
    func test_didUpdateDetailSuccess_givenBankNameDataReceivedIsNotNil_shouldDelegateSetBankName() {
        sut.didUpdateDetailsSuccess(Items.fixture(bankName: "Banco Phi"))
        
        XCTAssertTrue(view.setBankNameCalled)
        XCTAssertEqual(view.setBankNamePassed, "Banco Phi")

    }
    
    func test_didUpdateDetailSuccess_givenBankNameDataReceivedIsNil_shouldDelegateSetBankName() {
        sut.didUpdateDetailsSuccess(Items.fixture(bankName: ""))
        
        XCTAssertTrue(view.setBankNameCalled)
        XCTAssertEqual(view.setBankNamePassed, "")
    }
    
    func test_didUpdateDetailSuccess_givenCreatedAtDataReceived_shouldDelegateCreatedAt() {
        sut.didUpdateDetailsSuccess(Items.fixture(createdAt: "2020-11-29T03:00:00Z"))
        
        XCTAssertTrue(view.setCreatedAtCalled)
        XCTAssertEqual(view.setCreatedAtPassed, "29/11/2020 - 03:00:00")
    }
    
    func test_didUpdateDetailSuccess_givenAuthenticationDataReceivedIsNotNil_shouldDelegateAuthentication() {
        sut.didUpdateDetailsSuccess(Items.fixture(authentication: "D33D7A0E-2252-47D6-9F4B-11D2356E4BC9"))
        
        XCTAssertTrue(view.setAuthenticationCalled)
        XCTAssertEqual(view.setAuthenticationPassed, "337022524769411235649")
    }
    
    func test_didUpdateDetailSuccess_givenAuthenticationDataReceivedIsNil_shouldDelegateAuthentication() {
        sut.didUpdateDetailsSuccess(Items.fixture(authentication: ""))
        
        XCTAssertTrue(view.setAuthenticationCalled)
        XCTAssertEqual(view.setAuthenticationPassed, "")
    }
    
    func test_didUpdateDetailSuccess_shouldDelegateHideLoader() {
        sut.didUpdateDetailsSuccess(Items.fixture())
        
        XCTAssertTrue(view.hideLoaderCalled)
    }
    
    func test_didUpdateDetailsFail_shouldDelegateHideLoader() {
        sut.didUpdateDetailsFail(AppError.generic)
        
        XCTAssertTrue(view.hideLoaderCalled)
    }
    
    func test_didUpdateDetailsFail_shouldDelegateShowError() {
        sut.didUpdateDetailsFail(AppError.generic)
        
        XCTAssertTrue(view.showErrorCalled)
        XCTAssertEqual(view.showErrorPassed, "Ops, something went wrong. Try again later.")
        
    }
    
    
    
}
