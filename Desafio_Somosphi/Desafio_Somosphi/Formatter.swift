//
//  Formatter.swift
//  Desafio_Somosphi
//
//  Created by Suh on 22/08/22.
//

import Foundation

struct Formatter {
    enum DateFormat: String {
        case long = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        case short = "dd/MM"
    }

    static func formatCurrency(value: Int) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencySymbol = "R$"
        formatter.alwaysShowsDecimalSeparator = true
        formatter.locale = Locale(identifier: "pt_BR")
        let number = formatter.string(from: NSNumber(value: value))
        return number ?? "R$ 0,00"
    }

    static func getDate(from value: String, using format: String) -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.date(from: value)
    }

    static func getDateString(from value: Date?, using format: String) -> String {
        guard let value = value else {
            return ""
        }

        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: value)
    }

    static func formatDate(
        string: String,
        from mask: DateFormat = .long,
        to format: DateFormat = .short
    ) -> String {
        let date = getDate(from: string, using: mask.rawValue)
        let result = getDateString(from: date, using: format.rawValue)
        return result
    }

}
