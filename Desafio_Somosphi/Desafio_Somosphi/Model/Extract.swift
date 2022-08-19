//
//  ExtractModel.swift
//  Desafio_Somosphi
//
//  Created by Suh on 06/08/22.
//

import UIKit

struct Extract: Codable {
    var createdAt: String
    var userId: String
    var amount: Int
    var target: String
    var description: String
    var tType: String

    enum CondingKeys: String, CodingKey {
        case createdAt, amount, description, tType
        case userId = "id"
        case onto = "to"
    }
}

#if DEBUG
extension Extract {
    static func fixture(
        createdAt: String = "2020-10-22T03:00:00Z",
        userId: String = "E79E0C9A-46AE-4DBA-82F5-D0BACC53F6CF",
        amount: Int = 1807,
        target: String = "David Bond",
        description: String = "Transferência realizada",
        tType: String = "TRANSFEROUT"
    ) -> Extract {
        Extract(
            createdAt: createdAt,
            userId: userId,
            amount: amount,
            target: target,
            description: description,
            tType: tType
        )

    }
}
#endif

// "items": [
// {
//    "createdAt": "2020-10-22T03:00:00Z",
//    "id": "E79E0C9A-46AE-4DBA-82F5-D0BACC53F6CF",
//    "amount": 1807,
//    "to": "David Bond",
//    "description": "Transferência realizada",
//    "tType": "TRANSFEROUT"

//    "from": "Arthur Hunt",
//    "bankName": "Banco Phi",
