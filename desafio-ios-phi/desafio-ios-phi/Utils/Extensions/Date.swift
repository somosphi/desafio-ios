//
//  Date.swift
//  desafio-ios-phi
//
//  Created by Lidiane Gomes Barbosa on 11/05/21.
//

import UIKit

extension Date {
   
    var toString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/YYYY - HH:MM:ss"
        return dateFormatter.string(from: self)
    }
    
    var toShortString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM"
        return dateFormatter.string(from: self)
    }
}
