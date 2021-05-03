//
//  Router.swift
//  desafio-ios-phi
//
//  Created by Lidiane Gomes on 28/04/21.
//

import Foundation

enum Router {
    case myBalance
    case mySatatemet(limit: Int, offset: Int)
    case myStatementDetail(transactionID: String)
    
    private var scheme: String {
        return APISCHEME
    }
    
    private var host: String {
        return APIHOST
    }
    
    private var path: String {
        switch self {
        case .myBalance:
            return "/myBalance"
        case .mySatatemet(let limit, let offset):
            return "/myStatement/\(limit)/\(offset)"
        case .myStatementDetail(let transactionID):
            return "/myStatement/detail/\(transactionID)"
        }
    }
    
    private var header: [String: String] {
        return ["token": APITOKEN]
    }
    
    private var method: String {
        return HTTPMethods.GET.rawValue
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
