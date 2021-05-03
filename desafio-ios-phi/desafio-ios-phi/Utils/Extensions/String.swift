//
//  String.swift
//  desafio-ios-phi
//
//  Created by Lidiane Gomes on 30/04/21.
//

import Foundation
extension String {
    static let dateFormatter = DateFormatter()
    
    static func fromDate(_ date: Date) -> Self {
        dateFormatter.dateFormat = "dd/MM/YYYY - HH:MM:ss"
        return dateFormatter.string(from: date)
    }
    
    static func fromDateResume(_ date: Date) -> Self {
        dateFormatter.dateFormat = "dd/MM"
        return dateFormatter.string(from: date)
    }
}
