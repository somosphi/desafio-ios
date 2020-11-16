//
//  Fixtures.swift
//  PhiChallengeTests
//
//  Created by Felipe Wilke on 15/11/20.
//

import Foundation

@testable import PhiChallenge

extension BalanceResponse {
    static func fixture(amount: Int? = nil) -> BalanceResponse {
        
        return BalanceResponse(amount: amount ?? 0)
        
    }
}

extension StatementResponse {
    static func fixture(items: [Items]) -> StatementResponse {
        
        return StatementResponse(items: items)
    }
}

extension Items {
    static func fixture(createdAt: String? = "",
                        id: String? = "",
                        amount: Int? = 0,
                        description: String? = "",
                        tType: String? = "",
                        bankName: String? = "",
                        from: String? = "",
                        to: String? = "",
                        authentication: String? = "") -> Items {
        
        return Items(createdAt: createdAt ?? "",
                     id: id ?? "",
                     amount: amount ?? 0,
                     description: description ?? "",
                     tType: tType ?? "",
                     bankName: bankName,
                     from: from,
                     to: to,
                     authentication: authentication)
    }
}


