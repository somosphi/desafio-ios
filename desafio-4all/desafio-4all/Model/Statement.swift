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
    let amount: Int
    let description: String?
    let tType: String?
    let from: String?
    let to: String?
    let bankName: String?
    let createdAt: Date?
}

