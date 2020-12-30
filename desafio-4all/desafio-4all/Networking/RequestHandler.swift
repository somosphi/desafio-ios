//
//  RequestHandler.swift
//  desafio-4all
//
//  Created by Vitor Demenighi on 29/12/20.
//

import Foundation
import KeychainSwift

typealias URLRequestInputValues = (url: URL, endPoint: Endpoint, parameters: [String: Any]?)

protocol RequestHandlerProtocol {
    func makeRequest(endPoint: Endpoint,
                     parameters: [String: Any]?) -> Result<URLRequest, Error>
}

extension RequestHandlerProtocol {
    
    // MARK: -  Request Handler Functions Default Implementation
    
    func makeRequest(endPoint: Endpoint,
                     parameters: [String: Any]?) -> Result<URLRequest, Error> {
        do {
            let urlResult = try createURL(path: endPoint.completePath).get()
            let urlRequestResult = try createURLRequest(inputValues: (urlResult, endPoint, parameters)).get()
            return .success(urlRequestResult)
        } catch {
            return .failure(error)
        }
    }
    
    private func createURL(path: String) -> Result<URL, Error> {
        guard let url = URL(string: path) else {
            return .failure(CustomError.invalidURL)
        }
        return .success(url)
    }
    
    private func createURLRequest(inputValues: URLRequestInputValues) -> Result<URLRequest, Error> {
        var urlRequest = URLRequest(url: inputValues.url)
        urlRequest.httpMethod = inputValues.endPoint.parameters.method.rawValue
        
        // MARK: Token
        if inputValues.endPoint.parameters.isAuth {
            let token = KeychainSwift().get(StringConstants.keychainTokenKey) ?? "blankToken"
            urlRequest.setValue(token, forHTTPHeaderField: StringConstants.authHeaderToken)
        }
        
        // MARK: Parameters
        if let parameters = inputValues.parameters {
            do {
                urlRequest.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
                return .success(urlRequest)
            } catch {
                return .failure(CustomError.failedAddParameters)
            }
        }
        
        return .success(urlRequest)
    }
}

class RequestHandler: RequestHandlerProtocol {}
