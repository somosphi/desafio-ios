//
//  StatementDetailViewModel.swift
//  desafio-ios-phi
//
//  Created by Lidiane Gomes on 27/04/21.
//

import Foundation
class StatementDetailViewModel {
    
    // MARK: - Properties
    
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
    
    var amount: String {
        guard let value = transaction?.amount.formattedWithSeparator else {
            return ""
        }
        return "R$ \(value)"
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
    
    // MARK: - Inicialization
    
    init(transactionId: String) {
        self.transactionId = transactionId
    }
    
    init(transaction: Statement) {
        self.transaction = transaction
        self.transactionId = transaction.uuid
    }

}

// MARK: - Network

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

// MARK: - Conforms to the Hashable

extension StatementDetailViewModel: Hashable {
    
    static func == (lhs: StatementDetailViewModel, rhs: StatementDetailViewModel) -> Bool {
        lhs.transactionId == rhs.transactionId
    }
    
    func hash(into hasher: inout Hasher) {
      hasher.combine(transactionId)
    }
    
}
