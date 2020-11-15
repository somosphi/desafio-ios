//
//  DetailsProtocols.swift
//  PhiChallenge
//
//  Created by Felipe Wilke on 13/11/20.
//

import Foundation

protocol DetailsScreenView: AnyObject {
    func showLoader()
    func hideLoader()
    func showError(message: String)
    func setAmount(with text: String)
    func setReceiver(with text: String)
    func setDescription(with text: String)
    func setBankName(with text: String)
    func setAuthentication(with text: String)
    func setCreatedAt(with text: String)
}
