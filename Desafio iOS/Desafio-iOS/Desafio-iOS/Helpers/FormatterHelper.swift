//
//  FormatterHelper.swift
//  Desafio-iOS
//
//  Created by Alex Freitas on 25/05/21.
//

import Foundation

struct FormatterHelper {
    static func detailedDate(date: String) -> String {
        let utcISODateFormatter = ISO8601DateFormatter()
        if let utcDate = utcISODateFormatter.date(from: date) {
            let formatter = DateFormatter()
            formatter.dateFormat = "dd/MM/yyyy - HH:mm:ss"
            return formatter.string(from: utcDate)
        }
        return "Detailed date formatter error."
    }

    static func shortDate(date: String) -> String {
        let utcISODateFormatter = ISO8601DateFormatter()
        if let utcDate = utcISODateFormatter.date(from: date) {
            let formatter = DateFormatter()
            formatter.dateFormat = "dd/MM"
            return formatter.string(from: utcDate)
        }
        return "Short date formatter error."
    }

    static func brCurrency(value: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        formatter.decimalSeparator = ","
        formatter.groupingSeparator = "."

        let number = NSNumber(value: value)
        let formattedValue = formatter.string(from: number)!
        return "R$ \(formattedValue)"
    }
}
