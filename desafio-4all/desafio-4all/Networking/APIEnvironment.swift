//
//  APIEnvironment.swift
//  desafio-4all
//
//  Created by Vitor Demenighi on 29/12/20.
//

import Foundation

enum Endpoint {
    
    // MARK: - Main endpoints
    
    case myBalance
    case myStatement(limit: Int = 10, offset: Int)
    case statementDetail(id: String)
    
    // MARK: - Test endpoints
    
    case invalidPath
    case withoutToken
}

typealias EndpointParameters = (path: String, method: HTTPMethod, isAuth: Bool)

extension Endpoint {
    
    private static let apiBaseURL = "https://desafio-mobile-bff.herokuapp.com/"
    
    var completePath: String {
        return Endpoint.apiBaseURL + self.parameters.path
    }
    
    var parameters: (EndpointParameters) {
        switch self {
        case .myBalance:
            return ("myBalance", .get, true)
            
        case .myStatement(let limit, let offset):
            return ("myStatement/\(limit)/\(offset)", .get, true)
            
        case .statementDetail(let id):
            return ("myStatement/detail/\(id)/", .get, true)
            
        case .invalidPath:
            return ("!)@#*(!(@*#", .get, false)
            
        case .withoutToken:
            return ("blankURL", .get, false)
        }
    }
}

enum HTTPMethod: String {
    case options = "OPTIONS"
    case get     = "GET"
    case head    = "HEAD"
    case post    = "POST"
    case put     = "PUT"
    case patch   = "PATCH"
    case delete  = "DELETE"
    case trace   = "TRACE"
    case connect = "CONNECT"
}

