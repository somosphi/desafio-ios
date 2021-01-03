//
//  StatementDetail.swift
//  desafio-4all
//
//  Created by Vitor Demenighi on 29/12/20.
//

import Foundation

struct StatementDetail: Decodable, Equatable {
    let amount: Double
    let id: String
    let authentication: String?
    let tType: String?
    let createdAt: Date?
    let to: String?
    let description: String?
    let bankName: String?
}

// MARK: - Statement Protocol

extension StatementDetail: StatementProtocol {
    
    func isTransferOut() -> Bool {
        return self.tType?.lowercased().contains("out") ?? false
    }
    
    func getCorrectlyAmount() -> Double {
        return isTransferOut() ? (amount * -1) : amount
    }
    
    func getCorrectlyFromString() -> String {
        guard let from = self.to else {
            return StringConstants.yourAccount
        }
        return from
    }
}
