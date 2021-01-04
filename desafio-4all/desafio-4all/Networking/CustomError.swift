//
//  CustomError.swift
//  desafio-4all
//
//  Created by Vitor Demenighi on 29/12/20.
//

import Foundation

enum CustomError: Error {
    
    case unknowError
    case responseDataNil
    case failedToDecode
    case invalidURL
    case failedAddParameters
    case requestResponseError
    case failedCastResponse
    case unknowCode(Int)
    case clientError(Int)
    case serverError(Int)
    case failedCastObject
    case incorrectOSVersion
    case castToDocumentError
    case getPageError
    case writeFileError
    
    var localizedDescription: String {
        get {
            switch self {
            case .unknowError:
                return ErrorConstants.unknowError
                
            case .responseDataNil:
                return ErrorConstants.responseDataNil
                
            case .failedToDecode:
                return ErrorConstants.failedToDecode
                
            case .invalidURL:
                return ErrorConstants.invalidURL
                
            case .failedAddParameters:
                return ErrorConstants.failedAddParameters
                
            case .requestResponseError:
                return ErrorConstants.requestResponseError
                
            case .failedCastResponse:
                return ErrorConstants.failedCastResponse
                
            case .unknowCode(let statusCode):
                return ErrorConstants.unknowCode + statusCode.codeString
                
            case .clientError(let statusCode):
                return ErrorConstants.clientError + statusCode.codeString
                
            case .serverError(let statusCode):
                return ErrorConstants.serverError + statusCode.codeString
                
            case .failedCastObject:
                return ErrorConstants.failedCastObject
                
            case .incorrectOSVersion:
                return ErrorConstants.incorrectOSVersion
                
            case .castToDocumentError:
                return ErrorConstants.castToDocumentError
                
            case .getPageError:
                return ErrorConstants.getPageError
                
            case .writeFileError:
                return ErrorConstants.writeFileError
            }
        }
    }
}
