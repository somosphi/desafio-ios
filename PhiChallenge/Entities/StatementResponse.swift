//
//  MyStatement.swift
//  PhiChallenge
//
//  Created by Felipe Wilke on 10/11/20.
//

import Foundation

struct StatementResponse: Decodable {
    var items: [Items]
}

struct Items: Decodable {
    var createdAt: String
    var id: String
    var amount: Int
    var description: String
    var tType: String
    var bankName: String?
    var from: String?
    var to: String?
    var authentication: String?
}



