//
//  MyBalanceProtocols.swift
//  PhiChallenge
//
//  Created by Felipe Wilke on 10/11/20.
//

import Foundation
protocol BalanceHeaderView: AnyObject {
    func setAmount(with value: Int)
    func hideAmount(with flag: Bool)
    
}
