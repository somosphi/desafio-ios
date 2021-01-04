//
//  UIColor.swift
//  desafio-4all
//
//  Created by Vitor Demenighi on 31/12/20.
//

import UIKit

extension UIColor {
    convenience init(hex: String) {
        let scanner = Scanner(string: hex)
        
        var rgbValue: UInt64 = 0
        
        scanner.scanHexInt64(&rgbValue)
        
        let r = (rgbValue & 0xff0000) >> 16
        let g = (rgbValue & 0xff00) >> 8
        let b = rgbValue & 0xff
        
        self.init(
            red: CGFloat(r) / 0xff,
            green: CGFloat(g) / 0xff,
            blue: CGFloat(b) / 0xff, alpha: 1
        )
    }
    
    static var appGray: UIColor {
        return UIColor(hex: "828282")
    }
    
    static var appBlack: UIColor {
        return UIColor(hex: "202021")
    }
    
    static var appLightGray: UIColor {
        return UIColor(hex: "F8F8F8")
    }
    
    static var appGreen: UIColor {
        return UIColor(hex: "00C1AF")
    }
}
