//
//  StatementCellProtocols.swift
//  PhiChallenge
//
//  Created by Felipe Wilke on 10/11/20.
//

import Foundation

protocol StatementCellView: AnyObject {
    func setDescription(with text: String)
    func setReceiver(with text: String)
    func setAmount(with value: Int)
    func setCreatedAt(with text: String)
    func showPixFlag(with flag: Bool)
}
