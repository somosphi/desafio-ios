//
//  Transaction.swift
//  desafio-ios-phi
//
//  Created by Lidiane Gomes on 27/04/21.
//

import Foundation

struct Transaction {
    let uuid: UUID?
    let date: Date?
    let amount: Double
    let description: String
    let type: TransactionType?
    var person: String?
    let bankName: String?
    let authentication: String?
    
    init(from data: DecodableTransaction) {
        self.uuid = UUID(uuidString: data.uuid)
        self.date = .formatFromString(data.date)
        self.amount = data.amount
        self.description = data.description
        self.type = TransactionType(rawValue: data.type)
        self.bankName = data.bankName
        self.authentication = data.authentication
        if let from = data.from, data.sentTo == nil {
            person = from
        } else if let sentTo = data.sentTo, data.from == nil {
            person = sentTo
        }
    }

}
