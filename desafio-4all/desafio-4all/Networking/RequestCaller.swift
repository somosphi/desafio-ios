//
//  RequestCaller.swift
//  desafio-4all
//
//  Created by Vitor Demenighi on 29/12/20.
//

import Foundation

typealias RequestResponse = (data: Data?, response: URLResponse?, error: Error?)

protocol RequestCallerProtocol {
    var session: NetworkSession { get }
    func callRequest(urlRequest: URLRequest, completion: @escaping (Result<Data?, Error>) -> Void)
    func handleResponse(requestResponse: RequestResponse, completion: @escaping (Result<Data?, Error>) -> Void)
}

class RequestCaller: RequestCallerProtocol {
    
    let session: NetworkSession
    
    init(session: NetworkSession = URLSession.shared) {
        self.session = session
    }
    
    func callRequest(urlRequest: URLRequest, completion: @escaping (Result<Data?, Error>) -> Void) {
        session.loadData(from: urlRequest) { (response) in
            self.handleResponse(requestResponse: response, completion: completion)
        }
    }
    
    func handleResponse(requestResponse: RequestResponse, completion: @escaping (Result<Data?, Error>) -> Void) {
        if let _ = requestResponse.error {
            completion(.failure(CustomError.requestResponseError))
            return
        }
        
        guard let httpResponse = requestResponse.response as? HTTPURLResponse else {
            completion(.failure(CustomError.failedCastResponse))
            return
        }
        
        switch httpResponse.statusCode {
        case 200...299: completion(.success(requestResponse.data))
        case 400...499: completion(.failure(CustomError.clientError(httpResponse.statusCode)))
        case 500...599: completion(.failure(CustomError.serverError(httpResponse.statusCode)))
        default:        completion(.failure(CustomError.unknowCode(httpResponse.statusCode)))
        }
    }
}

//MARK:- NetworkSession Protocol

protocol NetworkSession {
    func loadData(from url: URLRequest, completion: @escaping (RequestResponse) -> Void)
}

extension URLSession: NetworkSession {
    func loadData(from url: URLRequest, completion: @escaping (RequestResponse) -> Void) {
        let task = dataTask(with: url) { (data, response, error) in
            completion((data, response, error))
        }
        
        task.resume()
    }
}

//MARK:- NetworkSessionMock

class NetworkSessionMock: NetworkSession {
    var data: Data?
    var statusCode: Int? {
        didSet {
            guard let code = statusCode else { return }
            self.response = HTTPURLResponse(url: URL(string: "blankURL")!, statusCode: code, httpVersion: nil, headerFields: nil)
        }
    }
    var response: URLResponse?
    var error: Error?
    
    func loadData(from url: URLRequest, completion: @escaping (RequestResponse) -> Void) {
        completion((data, response, error))
    }
}
