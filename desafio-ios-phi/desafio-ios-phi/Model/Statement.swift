//
//  DecodableTransaction.swift
//  desafio-ios-phi
//
//  Created by Lidiane Gomes on 29/04/21.
//

import Foundation
struct Satatement: Decodable {
    let uuid: String
    let date: String
    let amount: Double
    let description: String
    let type: String
    let sentTo: String?
    let from: String?
    let bankName: String?
    let authentication: String

    enum CodingKeys: String, CodingKey {
        case uuid = "id", date = "createdAt", amount, description
        case type = "tType", bankName, sentTo = "to", from, authentication
    }
}
