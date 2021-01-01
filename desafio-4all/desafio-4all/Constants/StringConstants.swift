//
//  StringConstants.swift
//  desafio-4all
//
//  Created by Vitor Demenighi on 29/12/20.
//

import Foundation

struct StringConstants {
    // MARK: - Not Localizable
    
    static let keychainTokenKey = "KeychainToken"
    static let authHeaderToken = "token"
    static let balanceIsHiddenUserDefaults = "balanceIsHidden"
    
    // MARK: - Localizable
    
    static var statementTitle = NSLocalizedString("Extrato", comment: "")
    static var balanceTitle = NSLocalizedString("Seu saldo", comment: "")
    static var statementTableViewHeaderTitle = NSLocalizedString("Suas movimentações", comment: "")
    static var yourAccount = NSLocalizedString("Sua conta", comment: "")
}

struct ErrorConstants {
    static let responseDataNil = NSLocalizedString("ResponseDataNil", comment: "")
    static let failedToDecode = NSLocalizedString("FailedToDecode", comment: "")
    static let invalidURL = NSLocalizedString("InvalidURL", comment: "")
    static let failedAddParameters = NSLocalizedString("FailedAddParameters", comment: "")
    static let requestResponseError = NSLocalizedString("RequestResponseError", comment: "")
    static let failedCastResponse = NSLocalizedString("FailedCastResponse", comment: "")
    static let unknowCode = NSLocalizedString("UnknowCode", comment: "")
    static let clientError = NSLocalizedString("ClientError", comment: "")
    static let serverError = NSLocalizedString("ServerError", comment: "")
}

struct VariablePlaceholders {
//    static let name = "{name}"
}

