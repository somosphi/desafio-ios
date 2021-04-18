//
//  MyStatementItem.swift
//  DesafioIOS
//
//

import Foundation

struct MyStatementItem : Equatable{
    let id : String
    let type : StatementType
    let description : String
    let creationDate : String
    let destination : String
    let amountOfMoney : String
}

extension MyStatementItem{
    
    init(statementResponse : MyStatetmentResponse,
         statementDateFormatter : StatementDateFormatter,
         moneyFormatter : MoneyFormatter){
        self.id = statementResponse.id
        self.type = StatementType.fromMyStatementResponse(statementResponse)
        self.description = statementResponse.description
        self.creationDate = statementDateFormatter.simpleFormatDisplay(iso8601String: statementResponse.createdAt)
        self.destination = statementResponse.to ?? ""
        self.amountOfMoney = moneyFormatter.formatMoney(value : statementResponse.amount)
       
    }
}
