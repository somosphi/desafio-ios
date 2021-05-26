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
    let tType: TransferType

    // propriedades abaixo dependem do caso
//    let bankName: String
//    let from: String
//    let to: String
}

enum TransferType: String, Codable {
    case BANKSLIPCASHIN
    case BANKSLIPCASHOUT
    case PIXCASHIN
    case PIXCASHOUT
    case TRANSFERIN
    case TRANSFEROUT

    var description: String {
        switch self {
        case .BANKSLIPCASHIN:
            return "Depósito via boleto"
        case .BANKSLIPCASHOUT:
            return "Pagamento via boleto"
        case .PIXCASHIN:
            return "Transferência PIX recebida"
        case .PIXCASHOUT:
            return "Transferência PIX realizada"
        case .TRANSFERIN:
            return "Transferência recebida"
        case .TRANSFEROUT:
            return "Transferência realizada"
        }
    }
}
