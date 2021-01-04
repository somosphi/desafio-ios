//
//  StatementDetail.swift
//  desafio-4all
//
//  Created by Vitor Demenighi on 29/12/20.
//

import Foundation

struct StatementDetail: Decodable, Equatable, Exportable {
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
        return isTransferOut(tType: self.tType)
    }
    
    func getCorrectlyAmount() -> Double {
        return getCorrectlyAmount(amount: self.amount)
    }
    
    func getCorrectlyFromString() -> String {
        return getCorrectlyFromString(from: self.to)
    }
}
