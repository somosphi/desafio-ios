//
//  TransactionType.swift
//  desafio-ios-phi
//
//  Created by Lidiane Gomes on 28/04/21.
//

import Foundation
enum TransactionType: String, Decodable {
    case TRANSFEROUT, TRANSFERIN, PIXCASHIN, PIXCASHOUT, BANKSLIPCASHIN
}
