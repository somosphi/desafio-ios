//
//  ServiceLayerProtocols.swift
//  PhiChallenge
//
//  Created by Felipe Wilke on 11/11/20.
//

import Foundation

//MARK: - MyBalance API Request Protocols
protocol BalanceServiceInput: AnyObject {
    var outputBalance: BalanceServiceOutput? { get set }
    func fetchBalance()
}

protocol BalanceServiceOutput: AnyObject {
    func didUpdateBalanceSuccess(_ response: Int)
    func didUpdateBalanceFail(_ error: Error)
}

//MARK: - MyStatement API Request Protocols
protocol StatementServiceInput: AnyObject {
    var outputStatement: StatementServiceOutput? { get set }
    func fetchStatement(offset: String)
}

protocol StatementServiceOutput: AnyObject {
    func didUpdateStatementSuccess(_ response: [Items])
    func didUpdateStatementFail(_ error: Error)
}


//MARK: - Details API Request Protocols
protocol DetailsServiceInput: AnyObject {
    var outputDetails: DetailsServiceOutput? { get set }
    func fetchStatementID(id: String)
}

protocol DetailsServiceOutput: AnyObject {
    func didUpdateDetailsSuccess(_ response: Items)
    func didUpdateDetailsFail(_ error: Error)
}


