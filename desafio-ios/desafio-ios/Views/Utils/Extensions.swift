//
//  Extensions.swift
//  desafio-ios
//
//  Created by Gustavo Igor Gonçalves Travassos on 13/01/21.
//

import UIKit

public extension UIColor {
    
    static let phiGray = UIColor(red: 130/255, green: 130/255, blue: 130/255, alpha: 1)
    
    static let phiBlack = UIColor(red: 32/255, green: 32/255, blue: 33/255, alpha: 1)
    
    static let phiOffWhite = UIColor(red: 248/255, green: 248/255, blue: 248/255, alpha: 1)
    
    static let phiGreen = UIColor(red: 0, green: 193/255, blue: 175/255, alpha: 1)
    
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
