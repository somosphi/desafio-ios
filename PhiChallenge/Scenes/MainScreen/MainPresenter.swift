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
    private let router: MainRoutering
    
    private var balance: Int = 0
    var statements: [Items] = []
    var isFetchingBalance: Bool = false
    var isFetchingStatements: Bool = false
    private var offset: Int = 0
    
    //MARK: - Initialization
    
    init(router: MainRoutering, balanceService: BalanceServiceInput, statementService: StatementServiceInput) {
        self.router = router
        self.balanceService = balanceService
        self.statementService = statementService
        
        balanceService.outputBalance = self
        statementService.outputStatement = self
    }
    
    //MARK: - Functions
    
    func viewDidload() {
        
        fetchBalance()
        fetchStatements()
    }
    
    func fetchBalance() {
        
        isFetchingBalance = true
        balanceService.fetchBalance()
    }
    
    func fetchStatements() {
    
        view?.showLoader()
        
        isFetchingStatements = true
        statementService.fetchStatement(offset: "\(offset)")
        offset += 1
    }
    
    func tryAgain() {
        
        view?.showLoader()
        offset = 0
        statements = []
        view?.reloadTableViewData()
        fetchBalance()
        fetchStatements()
    }
    
    func didSelectItemAt(index: Int) {
        
        let statementId = statements[index].id
        
        router.navigateToDetailsScene(id: statementId)
        
    }
}

//MARK: - BalanceServiceOutput Interface Implementation

extension MainPresenter: BalanceServiceOutput {
    func didUpdateBalanceSuccess(_ response: Int) {
        
        balance = response
        
        isFetchingBalance = false
        view?.didUpdateBalance(with: balance)
    }
    
    func didUpdateBalanceFail(_ error: Error) {
        
        isFetchingBalance = false
        view?.showError(message: error.localizedDescription)
        
        
    }
}

//MARK: - StatementServiceOutput Interface Implementation
extension MainPresenter: StatementServiceOutput {
    func didUpdateStatementSuccess(_ response: [Items]) {
        
        for item in response {
            self.statements.append(item)
        }
        
        isFetchingStatements = false
        view?.hideLoader()
        view?.reloadTableViewData()
        
    }
    
    func didUpdateStatementFail(_ error: Error) {
        
        isFetchingStatements = false
        view?.hideLoader()
        view?.showError(message: error.localizedDescription)
    }
}



