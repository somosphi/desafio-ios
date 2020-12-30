//
//  StatementDetail.swift
//  desafio-4all
//
//  Created by Vitor Demenighi on 29/12/20.
//

import Foundation

struct StatementDetail: Decodable, Equatable {
    let amount: Int
    let id: String
    let authentication: String
    let tType: String
    let createdAt: Date
    let to: String
    let description: String
}
