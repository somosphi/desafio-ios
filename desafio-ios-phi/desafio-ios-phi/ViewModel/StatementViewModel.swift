//
//  StatementViewModel.swift
//  desafio-ios-phi
//
//  Created by Lidiane Gomes on 27/04/21.
//

import Foundation
class StatementViewModel {
    
    // MARK: - Properties
    
    private var balance: Balance?
    var statement = [StatementDetailViewModel]()
    
    var amount: String {
        guard let value = balance?.amount else {
            return ""
        }
        return value.formattedWithSeparator
    }
    
    // MARK: - Functions
    
    private func getTransaction(for index: Int) -> StatementDetailViewModel? {
        if statement.count > index {
            return statement[index]
        }
        return nil
    }
    
    func getTransactionId(for index: Int) -> String? {
        let transaction = getTransaction(for: index)
        return transaction?.uuid
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
    
    func getStatement(limit: Int = 10, offset: Int = 0, completion :@escaping (StatementViewModel) -> Void) {
        Service.getMyStatement(limit: limit, offset: offset) { statement in
            self.statement = statement.map {StatementDetailViewModel(transaction: $0)}
            
            DispatchQueue.main.async {
                completion(self)
            }
        }
    }
}
