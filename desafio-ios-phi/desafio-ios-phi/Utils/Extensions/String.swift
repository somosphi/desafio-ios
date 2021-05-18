//
//  String.swift
//  desafio-ios-phi
//
//  Created by Lidiane Gomes on 30/04/21.
//

import Foundation

extension String {
    var toDate: Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT+00:00")
        return dateFormatter.date(from: self)
    }
}
