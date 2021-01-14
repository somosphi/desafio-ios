//
//  Extensions.swift
//  desafio-ios
//
//  Created by Gustavo Igor Gonçalves Travassos on 13/01/21.
//

import UIKit

public extension UIColor {
    
    static let phiGray = UIColor(red: 130/255,
                                 green: 130/255,
                                 blue: 130/255,
                                 alpha: 1)
    
    static let phiBlack = UIColor(red: 32/255,
                                  green: 32/255,
                                  blue: 33/255,
                                  alpha: 1)
    
    static let phiOffWhite = UIColor(red: 248/255,
                                     green: 248/255,
                                     blue: 248/255,
                                     alpha: 1)
    
    static let phiGreen = UIColor(red: 0,
                                  green: 193/255,
                                  blue: 175/255,
                                  alpha: 1)
    
}

public extension UIView {
    
    func addSubview(_ subview: UIView, constraints: Bool) {
        addSubview(subview)
        subview.translatesAutoresizingMaskIntoConstraints = !constraints
    }
    
    func addSubviews(_ subviews: [UIView], constraints: Bool) {
        for subview in subviews {
            addSubview(subview)
            subview.translatesAutoresizingMaskIntoConstraints = !constraints
        }
    } 
}

public extension String {
    func formatDate(inputSymbols: String, outputSymbols: String) -> String {
        let inputDateFormatter = DateFormatter()
        inputDateFormatter.dateFormat = inputSymbols
        
        guard let date = inputDateFormatter.date(from: self) else {
            return .init()
        }
        
        let outputDateFormatter = DateFormatter()
        outputDateFormatter.dateFormat = outputSymbols
        
        return outputDateFormatter.string(from: date)
    }
    
    var formatToCurrency: String {
        let formatter = NumberFormatter()
        formatter.locale = .init(identifier: "PT-BR")
        formatter.numberStyle = .currencyAccounting
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2
        
        var amount = self
        
        do {
            let regex = try NSRegularExpression(pattern: "[^0-9]", options: .caseInsensitive)
            amount = regex.stringByReplacingMatches(in: amount, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, self.count), withTemplate: "")
            
            let double = (amount as NSString).doubleValue
            let number = NSNumber(value: (double / 100))
            
            guard number != 0 as NSNumber else {
                return ""
            }
            
            guard let formattedString = formatter.string(from: number) else {
                return ""
            }
            
            return formattedString
            
        } catch {
            return ""
        }
    }
}
