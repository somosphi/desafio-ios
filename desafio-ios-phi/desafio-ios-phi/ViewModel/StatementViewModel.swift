//
//  StatementViewModel.swift
//  desafio-ios-phi
//
//  Created by Lidiane Gomes on 27/04/21.
//

import Foundation
class StatementViewModel {
    
    // MARK: - Properties
    var isPaginating = false
    private var balance: Balance?
    private var listOfTransactions = [StatementDetailViewModel]()
    
    var amount: String {
        guard let value = balance?.amount else {
            return ""
        }
        return value.formattedWithSeparator
    }
    
    // MARK: - Functions
    
    func getAllTransactions() -> [StatementDetailViewModel] {
        return listOfTransactions
    }
    
    func getStatementDetailId(for index: Int) -> String? {
        var statementDetail: StatementDetailViewModel?
        if listOfTransactions.count > index {
            statementDetail = self.listOfTransactions[index]
        }
        return statementDetail?.uuid
    }
}

// MARK: - Network

extension StatementViewModel {
    
    func getMyBalance(completion :@escaping (StatementViewModel) -> Void) {
        Service.getMyBalance { balance in
            self.balance = balance
            
            DispatchQueue.main.async {
                completion(self)
            }
        }
    }
    
    func getStatement(completion :@escaping (StatementViewModel) -> Void) {
        Service.getMyStatement(limit: 10, offset: 0) { statement in
            self.listOfTransactions = statement.map {StatementDetailViewModel(transaction: $0)}
            
            DispatchQueue.main.async {
                completion(self)
            }
        }
    }
    
    func getStatementWithPagination(pagination: Bool = false,
                                    limit: Int = 10,
                                    offset: Int = 0,
                                    completion :@escaping (StatementViewModel, [StatementDetailViewModel]) -> Void) {
        if pagination {
            isPaginating = true
        }
        Service.getMyStatement(limit: limit, offset: offset) { statement in
            let newStatements = statement.map {StatementDetailViewModel(transaction: $0)}
            self.listOfTransactions += newStatements
            DispatchQueue.main.async {
                completion(self, newStatements)
                if pagination {
                    self.isPaginating = false
                }
            }
        }
    }
}
