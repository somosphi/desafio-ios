//
//  String+Extension.swift
//  desafio-phi
//
//  Created by Marcus Vinicius Vieira Badiale on 01/03/21.
//

import Foundation

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
}
