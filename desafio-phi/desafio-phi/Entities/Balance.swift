//
//  Balance.swift
//  desafio-phi
//
//  Created by Marcus Vinicius Vieira Badiale on 25/02/21.
//

import Foundation

struct Balance: Codable {
    let amount: Double
    
    init() {
        self.amount = 0
    }
}

extension Balance {
    ///Um resource para o array de todas as vagas  contendo a url do request e a funçao de parse
    static var myBalance: Resource<Balance> {
        
        return Resource<Balance>(url: .myBalance) { data in
            
            var balance: Balance?
            
            do {
                let decoder = JSONDecoder()
                balance = try decoder.decode(Balance.self, from: data)
            } catch {
                debugPrint("Decode error: ", error)
            }
            
            return balance
        }
    }
}
