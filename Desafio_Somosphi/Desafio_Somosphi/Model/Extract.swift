//
//  ExtractModel.swift
//  Desafio_Somosphi
//
//  Created by Suh on 06/08/22.
//

import UIKit

struct Extract: Codable {
    var createdAt: String
    var id: String
    var amount: Int
    var to: String
    var description: String
    var tType: String

}

extension Extract {
    static func fixture(
        createdAt: String = "2020-10-22T03:00:00Z",
        id: String = "E79E0C9A-46AE-4DBA-82F5-D0BACC53F6CF",
        amount: Int = 1807,
        to: String = "David Bond",
        description: String = "Transferência realizada",
        tType: String = "TRANSFEROUT"
    ) -> Extract {
        Extract(
            createdAt: createdAt,
            id: id,
            amount: amount,
            to: to,
            description: description,
            tType: tType
        )

    }
}
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
