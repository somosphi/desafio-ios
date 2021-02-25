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
    
    static var statementList: Resource<[Statement]> {
        
        return Resource<[Statement]>(url: .myStatementList(withOffset: 0)) { data in
            
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
