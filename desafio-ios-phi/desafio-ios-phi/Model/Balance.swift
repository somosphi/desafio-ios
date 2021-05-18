//
//  Balance.swift
//  desafio-ios-phi
//
//  Created by Lidiane Gomes on 27/04/21.
//

import Foundation

struct Balance: Decodable {
    var amount: Double?
    
    init(amount: Double?) {
        self.amount = amount
    }
}
