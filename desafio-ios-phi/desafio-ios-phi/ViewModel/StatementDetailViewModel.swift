//
//  TransactionViewModel.swift
//  desafio-ios-phi
//
//  Created by Lidiane Gomes on 27/04/21.
//

import Foundation
class TransactionViewModel {
    private var transaction: Satatement?
    var uuid: UUID? {
        return UUID(uuidString: transaction?.uuid ?? "")
    }
    var date: Date? {
        return Date.formatFromString(transaction?.date ?? "")
    }
    var amount: Double {
        return transaction?.amount ?? 0
    }
    var description: String {
        return transaction?.description ?? ""
    }
    var typeOfBankTransaction: String {
        let type = TransactionType(rawValue: transaction?.type ?? "") ?? .UNKNOWN
        switch type {
        case .TRANSFEROUT:
            return "Transferência realizada"
        case .TRANSFERIN:
            return "Transferência recebida"
        case .PIXCASHIN:
            return "Transferência PIX recebida"
        case .PIXCASHOUT:
            return "Transferência PIX realizada"
        case .BANKSLIPCASHIN:
            return "Depósito via boleto"
        default:
              return "Transferência recebida"
        }
        
    }
    var person: String {
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
        Service.getMyStatementDetail(transactionID: transactionId) { transaction in
            guard let transaction = transaction else {
                return
            }
            self.transaction = transaction
        }
    }
    
    
}
