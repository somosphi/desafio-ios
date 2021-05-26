//
//  StatementDetail.swift
//  Desafio-iOS
//
//  Created by Alex Freitas on 23/05/21.
//

import Foundation

struct StatementDetail: Codable {
    let createdAt: String
    let id: String
    let amount: Double
    let to: String?
    let bankName: String?
    let from: String?
    let description: String
    let tType: String
    let authentication: String

    var person: String? {
        return to ?? from ?? nil
    }

    var personType: String? {
        if to != nil {
            return "Recebedor(a)"
        } else if from != nil {
            return "Transferidor(a)"
        }

        return nil
    }
}
