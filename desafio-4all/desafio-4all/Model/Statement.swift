//
//  Statement.swift
//  desafio-4all
//
//  Created by Vitor Demenighi on 29/12/20.
//

import Foundation

struct Statement: Decodable {
    let items: [Item]
}

struct Item: Decodable, Equatable {
    let id: String
    let amount: Double
    let description: String?
    let tType: String?
    let from: String?
    let to: String?
    let bankName: String?
    let createdAt: Date?
    
}

extension Item: StatementProtocol {
    
    func isTransferOut() -> Bool {
        return isTransferOut(tType: self.tType)
    }
    
    func getCorrectlyAmount() -> Double {
        return getCorrectlyAmount(amount: self.amount)
    }
    
    func getCorrectlyFromString() -> String {
        return getCorrectlyFromString(from: self.from)
    }
    
    func isPix() -> Bool {
        return isPix(tType: self.tType)
    }
}

// MARK: - Statement Protocol

protocol StatementProtocol {
    func isTransferOut() -> Bool
    func getCorrectlyAmount() -> Double
    func getCorrectlyFromString() -> String
}

// MARK: - Default Implementation

extension StatementProtocol {
    
    func isTransferOut(tType: String?) -> Bool {
        return tType?.lowercased().contains("out") ?? false
    }
    
    func getCorrectlyAmount(amount: Double) -> Double {
        return isTransferOut() ? (amount * -1) : amount
    }
    
    func getCorrectlyFromString(from: String?) -> String {
        guard let from = from else {
            return StringConstants.yourAccount
        }
        return from
    }
    
    func isPix(tType: String?) -> Bool {
        return tType?.lowercased().contains("pix") ?? false
    }
}


