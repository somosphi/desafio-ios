//
//  Statement.swift
//  desafio-ios
//
//  Created by Gustavo Igor Gonçalves Travassos on 12/01/21.
//

import Foundation

// MARK: - Struct

struct Statement: Decodable {
    let createdAt: String
    let id: String
    let amount: Double
    let to: String
    let description: String
    let tType: String
}

struct StatementArray: Decodable {
    var array: [Statement]
}
