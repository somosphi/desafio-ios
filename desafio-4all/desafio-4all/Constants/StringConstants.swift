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
    static var receiptTitle = NSLocalizedString("Comprovante", comment: "")
    static var movementTypeTitle = NSLocalizedString("Tipo de movimentação", comment: "")
    static var valueTitle = NSLocalizedString("Valor", comment: "")
    static var fromTitle = NSLocalizedString("Recebedor", comment: "")
    static var bankNameTitle = NSLocalizedString("Instituição bancária", comment: "")
    static var dateTitle = NSLocalizedString("Data/Hora", comment: "")
    static var autenticationTitle = NSLocalizedString("Autenticação", comment: "")
    static var shareButtonTitle = NSLocalizedString("Compartilhar", comment: "")
    static var emptyBankName = NSLocalizedString("Não informada", comment: "")
}

// MARK: -  Error Constants

struct ErrorConstants {
    
    static let unknowError = NSLocalizedString("UnknowError", comment: "")
    static let responseDataNil = NSLocalizedString("ResponseDataNil", comment: "")
    static let failedToDecode = NSLocalizedString("FailedToDecode", comment: "")
    static let invalidURL = NSLocalizedString("InvalidURL", comment: "")
    static let failedAddParameters = NSLocalizedString("FailedAddParameters", comment: "")
    static let requestResponseError = NSLocalizedString("RequestResponseError", comment: "")
    static let failedCastResponse = NSLocalizedString("FailedCastResponse", comment: "")
    static let unknowCode = NSLocalizedString("UnknowCode", comment: "")
    static let clientError = NSLocalizedString("ClientError", comment: "")
    static let serverError = NSLocalizedString("ServerError", comment: "")
    static let failedCastObject = NSLocalizedString("FailedCastObject", comment: "")
    static let incorrectOSVersion = NSLocalizedString("IncorrectOSVersion", comment: "")
    static let castToDocumentError = NSLocalizedString("CastToDocumentError", comment: "")
    static let getPageError = NSLocalizedString("GetPageError", comment: "")
    static let writeFileError = NSLocalizedString("WriteFileError", comment: "")
}

