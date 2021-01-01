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
    
    func isTransferOut() -> Bool {
        return self.tType?.lowercased().contains("out") ?? false
    }
    
    func isPix() -> Bool {
        return self.tType?.lowercased().contains("pix") ?? false
    }
    
    func getCorrectlyAmount() -> Double {
        return isTransferOut() ? (amount * -1) : amount
    }
    
    func getCorrectlyFromString() -> String {
        guard let from = self.from else {
            return StringConstants.yourAccount
        }
        return from
    }
}


