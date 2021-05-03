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
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 2
        return formatter
    }()
}

extension Double {
    var formattedWithSeparator: String {
        return Formatter.withSeparator.string(for: self) ?? ""
    }
}
