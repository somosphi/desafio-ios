//
//  StatementDetailViewModel.swift
//  desafio-ios-phi
//
//  Created by Lidiane Gomes on 27/04/21.
//

import Foundation
class StatementDetailViewModel {
    
    private var transaction: Statement?
    private var transactionId: String
    
    var uuid: String {
        return transaction?.uuid ?? ""
    }
    
    var date: String {
        let date = Date.fromString(transaction?.date ?? "")
        return String.fromDate(date ?? Date())
    }
    
    var dateResume: String {
        let date = Date.fromString(transaction?.date ?? "")
        return String.fromDateResume(date ?? Date())
    }
    
    var amount: Double {
        return transaction?.amount ?? 0
    }
    
    var description: String {
        return transaction?.description ?? ""
    }
    
    var type: TransactionType? {
       return TransactionType(rawValue: transaction?.type ?? "")
    }
    
    var userName: String {
        if let from = transaction?.from, transaction?.sentTo == nil {
            return from
        } else if let sentTo = transaction?.sentTo, transaction?.from == nil {
            return sentTo
        }
        return ""
    }
    
    var bankName: String? {
        return transaction?.bankName
    }
    
    var authentication: String {
        return transaction?.authentication ?? ""
    }
    
    init(transactionId: String) {
        self.transactionId = transactionId
    }
    
    init(transaction: Statement) {
        self.transaction = transaction
        self.transactionId = transaction.uuid
    }

}

extension StatementDetailViewModel {
    func get(transactionId: String, completion :@escaping (StatementDetailViewModel) -> Void) {
        Service.getMyStatementDetail(transactionID: transactionId) { transaction in
            self.transaction = transaction
            
            DispatchQueue.main.async {
                completion(self)
            }
        }
    }
}
