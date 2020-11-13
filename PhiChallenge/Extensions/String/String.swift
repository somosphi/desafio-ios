//
//  String.swift
//  PhiChallenge
//
//  Created by Felipe Wilke on 11/11/20.
//

import Foundation

extension String {
    
    func removeCharacters(charactersOf string: String) -> String {
        let characterSet = CharacterSet(charactersIn: string)
        let components = self.components(separatedBy: characterSet)
        return components.joined(separator: " ")
    }
    

    
    
    func dataFormatter(dateFormat: String, dateToBeFormatted: String) -> String {
        
        var formattedData: String = ""
        
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = dateFormat
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateToBeFormatted
        
        if let date = dateFormatterGet.date(from: self) {
            
            formattedData = dateFormatter.string(from: date)
            
        } else {
            print("There was an error decoding the string")
        }
        return formattedData
    }
    
}
