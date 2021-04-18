//
//  DateFormatter.swift
//  DesafioIOS
//
//

import Foundation

class StatementDateFormatter{
    
    static let shared = StatementDateFormatter()
    
    private let isoDateFormatter = ISO8601DateFormatter()
    private let simpleDisplayDateFormatter = DateFormatter()
    private let completeDisplayDateFormatter = DateFormatter()
    
    private init(){
        simpleDisplayDateFormatter.dateFormat = "dd/MM"
        completeDisplayDateFormatter.dateFormat = "dd/MM/YYYY - HH:mm:ss"
    }
    
    func simpleFormatDisplay(iso8601String : String) -> String{
        let dateFromISO8601 = ISO8601DateFormatter().date(from : iso8601String)
        guard let date = dateFromISO8601 else { return "" }
        return simpleDisplayDateFormatter.string(from: date)
    }
    
    func completeFormatDisplay(iso8601String : String) -> String{
        let dateFromISO8601 = ISO8601DateFormatter().date(from : iso8601String)
        guard let date = dateFromISO8601 else { return "" }
        return completeDisplayDateFormatter.string(from: date)
    }
    
}
