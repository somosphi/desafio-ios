//
//  StatementResponse.swift
//  desafio-phi
//
//  Created by Marcus Vinicius Vieira Badiale on 25/02/21.
//

import Foundation

struct StatementResponse: Codable {
    let items: [Statement]
}

extension StatementResponse {
    
    static func list(with offSet: Int) -> Resource<[Statement]> {
        return Resource<[Statement]>(url: .myStatementList(withOffset: offSet)) { data in
            
            var statementList = [Statement]()
            
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(StatementResponse.self, from: data)
                statementList = response.items
            } catch {
                debugPrint("Decode error: ", error)
            }
            
            return statementList
        }
    }
}
