//
//  Transaction.swift
//  desafio-ios-phi
//
//  Created by Lidiane Gomes on 27/04/21.
//

import Foundation

struct Transaction: Codable {
    let uuid: UUID
    let date: Date
    let amount: Double
    let description: String
    let type: TransactionType
    let sentTo: String?
    let from: String?
    let bankName: String?

    enum CodingKeys: String, CodingKey {
        case uuid = "id", date = "createdAt", amount, description, type = "tType", bankName, sentTo = "to", from
    }
    
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        uuid = try container.decode(UUID.self, forKey: .uuid)
//        date = try container.decode(Date.self, forKey: .date)
//        amount = try container.decode(Double.self, forKey: .amount)
//        description = try container.decode(String.self, forKey: .description)
//        type = try container.decode(TransactionType.self, forKey: .type)
//        userName = try container.decode(String.self, forKey: .userName)
//        bankName = try container.decode(String.self, forKey: .bankName)
//    }
}
