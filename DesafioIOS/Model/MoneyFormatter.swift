//
//  MoneyFormatter.swift
//  DesafioIOS
//
//

import Foundation

class MoneyFormatter{
    
    static let shared = MoneyFormatter()
    
    private let formatter : NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.maximumFractionDigits = 2
        formatter.locale = Locale(identifier: "pt_BR")
        return formatter
    }()
    
    private init(){}
    
    func formatMoney(value : Double) -> String{
        return formatter.string(from: NSNumber(value: value)) ?? ""
    }
}
