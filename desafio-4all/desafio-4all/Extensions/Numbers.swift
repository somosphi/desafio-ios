//
//  Int.swift
//  desafio-4all
//
//  Created by Vitor Demenighi on 29/12/20.
//

import Foundation

extension Int {
    var codeString: String {
        return " Status code: \(self)"
    }
}

extension Double {
    func getReaisValue() -> String {
        var resultAmount = self
        var symbol = ""
        if self < 0 {
            resultAmount = self * -1
            symbol = "-"
        }
        
        let amountFormatString = String(format: "%.2f", resultAmount)
        let resultString = "\(symbol) R$ \(amountFormatString)"
        
        return resultString.replacingOccurrences(of: ".", with: ",")
    }
}
