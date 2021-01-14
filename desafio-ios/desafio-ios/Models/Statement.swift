//
//  Statement.swift
//  desafio-ios
//
//  Created by Gustavo Igor Gonçalves Travassos on 12/01/21.
//

import Foundation

struct Statement: Decodable {
    let createdAt: String
    let id: String
    let amount: Double
    let description: String
    let tType: String
    let to: String?
    let from: String?
    var bankName: String?
    let authentication: String?
}

struct StatementArray: Decodable {
    var items: [Statement]
}
