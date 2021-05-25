//
//  Formatter.swift
//  desafio-ios-phi
//
//  Created by Lidiane Gomes on 03/05/21.
//

import Foundation
extension Formatter {
    static let withSeparator: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.groupingSeparator = "."
        formatter.decimalSeparator = ","
        formatter.locale = Locale(identifier: "pt_BR")
        formatter.numberStyle = .currency
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2
        return formatter
    }()
}
