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
    let to: String
    let description: String
    let tType: String
    let authentication: String

    /*
     "amount": 1615,
     "id": "49E27207-F3A7-4264-B021-0188690F7D43",
     "authentication": "15BA0BB3-EFDB-44E9-99BA-3D0F8725C0E3",
     "tType": "PIXCASHIN",
     "createdAt": "2020-11-19T03:00:00Z",
     "to": "Karen Amidala",
     "description": "Transferência PIX recebida"
     */
}
