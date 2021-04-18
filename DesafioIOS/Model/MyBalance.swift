//
//  MyBalance.swift
//  DesafioIOS
//
//

import Foundation

struct MyBalance : Equatable{
    let value : String
}

extension MyBalance{
    init(myBalanceResponse : MyBalanceResponse, moneyFormatter : MoneyFormatter){
        self.value = moneyFormatter.formatMoney(value : myBalanceResponse.amount)
    }
}
