//
//  PhiChallengeTests.swift
//  PhiChallengeTests
//
//  Created by Felipe Wilke on 15/11/20.
//

import XCTest

@testable import PhiChallenge

class MainScreenPresenterTests: XCTestCase {

    private let view = MainScreenViewSpy()
    private let router = MainScreenRouterSpy()
    private let balanceService = MainScreenBalanceServiceSpy()
    private let statementService = MainScreenStatementsServiceSpy()
    private lazy var sut = MainPresenter(router: router, balanceService: balanceService, statementService: statementService)
  
    override func setUp() {
        sut.view = view
    }
    
    func test_viewDidLoad_shouldDelegateShowLoader() {
        sut.viewDidload()
        
        XCTAssertTrue(view.showLoaderCalled)
    }
    
    func test_viewDidLoad_shouldFetchBalance() {
        sut.viewDidload()
        
        XCTAssertTrue(balanceService.fetchBalanceCalled)
        
    }
    
    func test_viewDidLoad_shouldFetchStatements() {
        sut.viewDidload()
        
        XCTAssertTrue(statementService.fetchStatementCalled)
        XCTAssertEqual(statementService.fetchStatementPassed, "0")
    }
    
    func test_viewDidLoad_givenStatementServiceHasAlreadyBeenCalledBefore_shouldIncrementOffset() {
        sut.fetchStatements()
        sut.fetchStatements()
        
        XCTAssertEqual(statementService.fetchStatementPassed, "1")
    }
    
    func test_tryAgain_givenAlertActionButtonHasBeenTapped_shouldCallBalanceServiceAndStatementService() {
        sut.tryAgain()
        
        XCTAssertTrue(balanceService.fetchBalanceCalled)
        XCTAssertTrue(statementService.fetchStatementCalled)
        XCTAssertEqual(statementService.fetchStatementPassed, "0")
    }
    
    func test_didUpdateBalanceSuccess_givenDataReceived_shouldDelegateDidUpdateBalance() {
        sut.didUpdateBalanceSuccess(1325)
        
        XCTAssertTrue(view.didUpdateBalanceCalled)
    }
    
    func test_didUpdateBalanceFail_shouldDelegateShowError () {
        sut.didUpdateBalanceFail(AppError.generic)
        
        XCTAssertTrue(view.showErrorCalled)
        XCTAssertEqual(view.showErrorPassed, "Ops, something went wrong. Try again later.")
    }
    
    func test_didUpdateStatementSuccess_givenDataReceived_shouldDelegateHideLoader() {
        sut.didUpdateStatementSuccess([Items.fixture()])
        
        XCTAssertTrue(view.hideLoaderCalled)
        
    }
    
    func test_didUpdateStatementSuccess_givendataReceived_shouldDelegateReloadTableViewData() {
        sut.didUpdateStatementSuccess([Items.fixture()])
        
        XCTAssertTrue(view.reloadTableViewDataCalled)
        
    }
    
    func test_didUpdateStatementSuccess_givenNoDataReceived_shouldDelegateHideLoader() {
        sut.didUpdateStatementSuccess([])
        
        XCTAssertTrue(view.hideLoaderCalled)
        
    }
    
    func test_didUpdateStatementSuccess_givenNodataReceived_shouldDelegateReloadTableViewData() {
        sut.didUpdateStatementSuccess([])
        
        XCTAssertTrue(view.reloadTableViewDataCalled)
        
    }
    
    func test_didUpdateStatementFail_shouldDelegateHideLoader() {
        sut.didUpdateStatementFail(AppError.generic)
        
        XCTAssertTrue(view.hideLoaderCalled)
        
    }
    
    func test_didUpdateStatementfail_shouldDelegateShowError() {
        sut.didUpdateStatementFail(AppError.generic)
        
        XCTAssertTrue(view.showErrorCalled)
        XCTAssertEqual(view.showErrorPassed, "Ops, something went wrong. Try again later.")
        
    }
    
    func test_didSelectItemAt_shouldRouterTodetailsScene() {
        sut.statements = [Items.fixture(id: "0"),
                          Items.fixture(id: "1"),
                          Items.fixture(id: "2"),
                          Items.fixture(id: "3"),
                          Items.fixture(id: "4"),
                          Items.fixture(id: "5")]
        
        
        sut.didSelectItemAt(index: 2)
        
        XCTAssertTrue(router.navigateToDetailsSceneCalled)
        XCTAssertEqual(router.navigateToDetailsScenePassed, "2")
    }

}
