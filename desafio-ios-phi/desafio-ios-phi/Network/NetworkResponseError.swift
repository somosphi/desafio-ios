//
//  NetworkResponseError.swift
//  desafio-ios-phi
//
//  Created by Lidiane Gomes on 28/04/21.
//

import Foundation

enum NetWorkResponseError: Error {
    case requestFailed(description: String)
    case malformedURLRequest(url: String)
    case notFound
    case badRequest
    case unknownError(statusCode: Int)
    case decodableDataError
    
    var localizedDescription: String {
        switch self {
        case .requestFailed(let description):
            return description
            
        case .malformedURLRequest(let url):
            return "Could not build URLRequest with \(url)"
            
        case .notFound:
            return "The Request returned status code 404, the route was not found."
            
        case .badRequest:
            return "The Request returned status code 400, Bad Request."
            
        case .unknownError(let statusCode):
            return "The Request returned status code \(statusCode), unknown meaning."
            
        case .decodableDataError:
            return "The datas could not be decodable."
        }
    }
}
