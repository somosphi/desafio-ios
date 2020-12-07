//
//  Statement.swift
//  desafio-ios
//
//  Created by Alexandre Scheer Bing on 07/12/20.
//

import Foundation
struct Statement: Decodable {
    var tType: String
    var createdAt: String
    var to: String
    var description: String
    var amount: Int
    var id: String
}

struct StatementList: Decodable {
    var items:[Statement]
}
