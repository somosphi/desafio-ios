//
//  Router.swift
//  desafio-ios-phi
//
//  Created by Lidiane Gomes on 28/04/21.
//

import Foundation

enum Router {
    case getMyBalance
    case getMyStatement(limit: Int, offset: Int)
    case getMyStatementDetail(transactionID: String)
    
    private var scheme: String {
        return "https"
    }
    
    private var host: String {
        return "desafio-mobile-bff.herokuapp.com"
    }
    
    private var path: String {
        switch self {
        case .getMyBalance:
            return "/myBalance"
        case .getMyStatement(let limit, let offset):
            return "/myStatement/\(limit)/\(offset)"
        case .getMyStatementDetail(let transactionID):
            return "/myStatement/detail/\(transactionID)"
        }
    }
    
    private var header: [String: String] {
        return ["token":
                    "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiaWF0IjoxNTE2MjM5MDIyfQ.SflKxwRJSMeKKF2QT4fwpMeJf36POk6yJV_adQssw5c"
        ]
    }
    
    private var method: String {
        return "GET"
    }
    
    var url: URL? {
        var components = URLComponents()
        components.scheme = scheme
        components.host = host
        components.path = path
        return components.url
    }
    
    var urlRequest: URLRequest? {
        guard let url = self.url else {
            return nil
        }
        var request = URLRequest(url: url)
        request.httpMethod = self.method
        request.allHTTPHeaderFields = self.header
        return request
    }
}
