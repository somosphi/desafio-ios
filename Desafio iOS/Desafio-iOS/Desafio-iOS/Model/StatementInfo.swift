//
//  StatementInfo.swift
//  Desafio-iOS
//
//  Created by Alex Freitas on 23/05/21.
//

import Foundation

struct Response: Codable {
    var items: [StatementInfo]
}

struct StatementInfo: Codable {
    let createdAt: String
    let id: String
    let amount: Double
    let description: String
    let tType: String
    let bankName: String?
    let from: String?
    let to: String?
}
