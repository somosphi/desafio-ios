//
//  MyStatementDetail.swift
//  DesafioIOS
//
//

import Foundation

struct MyStatementDetailItem : Equatable{
    let title : String
    let value : String
}

struct MyStatementDetail : Equatable{
    let movementDescription : MyStatementDetailItem
    let amount : MyStatementDetailItem
    let receiver : MyStatementDetailItem
    let createdAt : MyStatementDetailItem
    let authentication : MyStatementDetailItem
    
    func itemsAsList() -> [MyStatementDetailItem]{
        return [movementDescription, amount, receiver, createdAt, authentication]
    }
}

extension MyStatementDetail{
    init(myStatementDetailResponse : MyStatetementDetailResponse,
         moneyFormatter : MoneyFormatter,
         statementDateFormatter : StatementDateFormatter){
        
        self.movementDescription = MyStatementDetailItem(
            title: "Tipo de movimentação",
            value: myStatementDetailResponse.description)
        
        self.amount = MyStatementDetailItem(
            title: "Valor",
            value: moneyFormatter.formatMoney(value: myStatementDetailResponse.amount))
        
        self.receiver = MyStatementDetailItem(
            title: "Recebedor",
            value: myStatementDetailResponse.to)
        
        self.createdAt = MyStatementDetailItem(
            title: "Data/Hora",
            value: statementDateFormatter
                .completeFormatDisplay(iso8601String: myStatementDetailResponse.createdAt))
        
        self.authentication = MyStatementDetailItem(
            title: "Autenticação",
            value: myStatementDetailResponse.authentication)
    }
    
}
