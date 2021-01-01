//
//  Date.swift
//  desafio-4all
//
//  Created by Vitor Demenighi on 01/01/21.
//

import Foundation

extension Date {
    
    func getDayMonthFormat() -> String {
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "dd/MM"
        return dateFormatterPrint.string(from: self)
    }
}
