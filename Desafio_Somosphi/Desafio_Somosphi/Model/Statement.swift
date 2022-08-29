//
//  StatementModel.swift
//  Desafio_Somosphi
//
//  Created by Suh on 06/08/22.
//

import UIKit

struct Statement: Codable {
    var createdAt: String
    var statementID: String
    var amount: Int
    var target: String?
    var description: String
    var tType: String
    var from: String?
    var bankName: String?
    var authentication: String?

    enum CodingKeys: String, CodingKey {
        case createdAt, amount, description, tType, bankName, from, authentication
        case statementID = "id"
        case target = "to"
    }
}

extension Statement {
    var isTypePix: Bool {
        return [
            "PIXCASHIN",
            "PIXCASHOUT"
        ].contains(tType.uppercased())
    }

    var destinationName: String {
        if let target = target {
            return target
        } else if let from = from {
            return from
        }
        return ""

    }

    var typeTarget: String {
        if target != nil {
            return "Destinatario"
        } else if from != nil {
            return "Emissor"
        }
        return "Minha Conta"
    }

}

#if DEBUG
extension Statement {
    static func fixture(
        createdAt: String = "2020-10-22T03:00:00Z",
        statementID: String = "E79E0C9A-46AE-4DBA-82F5-D0BACC53F6CF",
        amount: Int = 1807,
        target: String = "David Bond",
        description: String = "Transferência realizada",
        authentication: String = "",
        tType: String = "TRANSFEROUT"
    ) -> Statement {
        Statement(
            createdAt: createdAt,
            statementID: statementID,
            amount: amount,
            target: target,
            description: description,
            tType: tType,
            authentication: authentication
        )

    }
}
#endif
