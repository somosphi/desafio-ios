//
//  MainPresenter.swift
//  PhiChallenge
//
//  Created by Felipe Wilke on 10/11/20.
//

import Foundation

final class MainPresenter {
    //MARK: - Properties
    
    weak var view: MainScreenView?
    
    private let balanceService: BalanceServiceInput
    private let statementService: StatementServiceInput
    
    private var userBalance: Int = 0
    var userStatements: [Items] = []
    var isFetchingBalance: Bool = false
    var isFetchingStatements: Bool = false
    private var offset: Int = 0
    
    //MARK: - Initialization
    
    init(balanceService: BalanceServiceInput, statementService: StatementServiceInput) {
        self.balanceService = balanceService
        self.statementService = statementService
        
        balanceService.outputBalance = self
        statementService.outputStatement = self
    }
    
    //MARK: - Functions
    
    func viewDidload() {
        
        fetchMyBalance()
        fetchMyStatements()
    }
    
    func fetchMyBalance() {
        
        guard !isFetchingBalance else {
            return
        }
        
        isFetchingBalance = true
        balanceService.fetchBalance()
    }
    
    func fetchMyStatements() {
        
        guard !isFetchingStatements else {
            return
        }
        
        view?.showLoader()
        
        isFetchingStatements = true
        statementService.fetchStatement(offset: "\(offset)")
        offset += 1
    }
    
    func tryAgain() {
        
        view?.showLoader()
        offset = 0
        userStatements = []
        view?.reloadTableViewData()
        fetchMyBalance()
        fetchMyStatements()
        view?.reloadTableViewData()
        view?.hideLoader()
    }
    
    func didSelectItemAt(index: Int) {
        
    }
}

//MARK: - BalanceServiceOutput Interface Implementation

extension MainPresenter: BalanceServiceOutput {
    func didUpdateBalanceSuccess(_ response: Int) {
        
        userBalance = response
        
        isFetchingBalance = false
        view?.didUpdateBalance(of: userBalance)
    }
    
    func didUpdatBalanceFail(_ error: Error) {
        
        view?.showError(message: error.localizedDescription)
        
        isFetchingBalance = false
    }
}

//MARK: - StatementServiceOutput Interface Implementation
extension MainPresenter: StatementServiceOutput {
    func didUpdateStatementSuccess(_ response: [Items]) {
        
        for item in response {
            self.userStatements.append(item)
        }
        
        isFetchingStatements = false
        view?.reloadTableViewData()
        view?.hideLoader()
    }
    
    func didUpdatStatementFail(_ error: Error) {
        isFetchingStatements = false
        view?.showError(message: error.localizedDescription)
    }
}



