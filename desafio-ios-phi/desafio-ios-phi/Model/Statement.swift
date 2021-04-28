//
//  Statement.swift
//  desafio-ios-phi
//
//  Created by Lidiane Gomes on 27/04/21.
//

import Foundation

struct Statement: Codable {
    var amount: Double
    var listOfTransactions: [Transaction]
}
