//
//  StatementType.swift
//  DesafioIOS
//
//

import Foundation

enum PixType : String, CaseIterable{
    case PIXCASHIN
    case PIXCASHOUT
    
    static func isPixType(type : String) -> Bool{
        return PixType.allCases.first(where: {pixType in pixType.rawValue == type}) != nil
    }
}

enum StatementType{
    case PIX
    case General
    
    static func fromMyStatementResponse(_ response : MyStatetmentResponse) -> StatementType{
        if(PixType.isPixType(type: response.tType.uppercased())){
            return .PIX
        }
        return .General
        
    }
}
