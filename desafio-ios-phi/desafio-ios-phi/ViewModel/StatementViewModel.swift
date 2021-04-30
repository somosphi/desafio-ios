//
//  StatementViewModel.swift
//  desafio-ios-phi
//
//  Created by Lidiane Gomes on 27/04/21.
//

import Foundation
class StatementViewModel {
    
    private var balance: Balance?
    private var statement = [StatementDetailViewModel]()
    
    var amount: Double {
        return balance?.amount ?? 0
    }
    
    var numberOfTransactions: Int {
        return statement.count
    }
    
    func transaction(for index: Int) -> StatementDetailViewModel? {
        if statement.count > index {
            return statement[index]
        }
        return nil
    }
    
    func updateBalance() {
        Service.getMyBalance { balance in
            self.balance = balance
        }
    }
}

extension StatementViewModel {
    
    func get(limit: Int = 10, offset: Int = 0, completion :@escaping (StatementViewModel) -> Void) {
        Service.getMyBalance { balance in
            self.balance = balance
        }
        
        Service.getMyStatement(limit: limit, offset: offset) { statement in
            self.statement = statement.map {StatementDetailViewModel(transaction: $0)}
        }
        
        DispatchQueue.main.async {
            completion(self)
        }
    }
}
