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
    var to: String?
    var from: String?
    var bankName: String?
    var description: String
    var amount: Double
    var id: String
    var authentication: String?
    
    var transferenceType: String {
        switch tType {
        case "PIXCASHIN":
            return "Transferência Pix recebida"
        case "PIXCASHOUT":
            return "Transferência Pix realizada"
        case "TRANSFEROUT":
                return "Transferência enviada"
        case "TRANSFERIN":
                return "Transferência recebida"
        case "BANKSLIPCASHIN":
            return "Depósito por boleto"
        default:
            return "Transferência"
        }
    }
    
    var amountString: String {
        if tType.contains("IN") {
            return "R$ \(String(format: "%.2f", amount))"
        }
        return "-R$ \(String(format: "%.2f", amount))"
    }
}

struct StatementList: Decodable {
    var items:[Statement]
}
