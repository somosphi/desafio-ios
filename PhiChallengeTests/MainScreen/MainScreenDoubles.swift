//
//  MainScreenDoubles.swift
//  PhiChallengeTests
//
//  Created by Felipe Wilke on 15/11/20.
//

import Foundation

@testable import PhiChallenge

final class MainScreenViewSpy: MainScreenView {
    
    private(set) var showLoaderCalled = false
    func showLoader() {
        showLoaderCalled = true
    }
    private(set) var hideLoaderCalled = false
    
    func hideLoader() {
        hideLoaderCalled = true
    }
    
    private(set) var showErrorCalled = false
    private(set) var showErrorPassed: String?
    
    func showError(message: String) {
        showErrorCalled = true
        showErrorPassed = message
    }
    
    private(set) var reloadTableViewDataCalled = false
    func reloadTableViewData() {
        reloadTableViewDataCalled = true
    }
    
    private(set) var didUpdateBalanceCalled = false
    private(set) var didUpdateBalancePassed: Int?
    
    func didUpdateBalance(with value: Int) {
        didUpdateBalanceCalled = true
        didUpdateBalancePassed = value
    }
}

final class MainScreenBalanceServiceSpy: BalanceServiceInput {
    var outputBalance: BalanceServiceOutput?
    
    private(set) var fetchBalanceCalled = false
    func fetchBalance() {
        fetchBalanceCalled = true
    }
}

final class MainScreenStatementsServiceSpy: StatementServiceInput {
    var outputStatement: StatementServiceOutput?
    
    private(set) var fetchStatementCalled = false
    private(set) var fetchStatementOffsetPassed: String?
    func fetchStatement(offset: String) {
        fetchStatementCalled = true
        fetchStatementOffsetPassed = offset
    }
}

final class MainScreenRouterSpy: MainRoutering {
    
    private(set) var navigateToDetailsSceneCalled = false
    private(set) var statementIdPassed: String?
    
    func navigateToDetailsScene(id: String) {
        navigateToDetailsSceneCalled = true
        statementIdPassed = id
        
    }
    
    
}
