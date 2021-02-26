//
//  Statement.swift
//  desafio-phi
//
//  Created by Marcus Vinicius Vieira Badiale on 25/02/21.
//

import Foundation

struct Statement: Codable {
    //MARK: - Non Optionals
    let createdAt: String
    let id: String
    let amount: Double
    let description: String
    let tType: String
    
    //MARK: - Optionals
    let to: String?
    let from: String?
    var bankName: String?
    let authentication: String?
    
    init() {
        self.createdAt = ""
        self.id = ""
        self.amount = 0
        self.description = ""
        self.tType = ""
        self.to = ""
        self.from = ""
        self.bankName = ""
        self.authentication = ""
    }
}

extension Statement {
    
    static func statement(withId id: String) -> Resource<Statement> {
        return Resource<Statement>(url: .myStatement(withId: id)) { data in
            
            var statement: Statement?
        
            do {
                let decoder = JSONDecoder()
                statement = try decoder.decode(Statement.self, from: data)
            } catch {
                debugPrint("Decode error: ", error)
            }
            
            return statement
        }
    }
}
