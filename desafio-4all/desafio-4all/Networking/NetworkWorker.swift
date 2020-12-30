//
//  NetworkWorker.swift
//  desafio-4all
//
//  Created by Vitor Demenighi on 29/12/20.
//

import Foundation

protocol NetworkWorkerProtocol {
    func performGenericRequest<T: Decodable>(endPoint: Endpoint,
                                             completion: @escaping(Result<T, CustomError>) -> Void)
    func performGenericRequest<T: Decodable>(endPoint: Endpoint,
                                             parameters: [String: Any]?,
                                             completion: @escaping (Result<T, CustomError>) -> Void)
}

class NetworkWorker: NetworkWorkerProtocol {
    
    let requestHandler: RequestHandlerProtocol
    let requestCaller: RequestCallerProtocol
    let requestParser: RequestParserProtocol
    
    init(requestHandler: RequestHandlerProtocol = RequestHandler(),
         requestCaller:  RequestCallerProtocol  = RequestCaller(),
         requestParser:  RequestParserProtocol  = RequestParser()) {
        self.requestHandler = requestHandler
        self.requestCaller = requestCaller
        self.requestParser = requestParser
    }
    
    func performGenericRequest<T: Decodable>(endPoint: Endpoint,
                                             completion: @escaping (Result<T, CustomError>) -> Void){
        performGenericRequest(endPoint: endPoint, parameters: nil, completion: completion)
    }
    
    func performGenericRequest<T: Decodable>(endPoint: Endpoint,
                                             parameters: [String: Any]?,
                                             completion: @escaping (Result<T, CustomError>) -> Void) {
        do {
            let requestResult = try requestHandler.makeRequest(endPoint: endPoint, parameters: parameters).get()
            
            requestCaller.callRequest(urlRequest: requestResult) { response in
                do {
                    let parsedResult: T = try self.requestParser.parseData(data: response.get()).get()
                    completion(.success(parsedResult))
                } catch {
                    guard let customError = error as? CustomError else {
                        return
                    }
                    completion(.failure(customError))
                }
            }
        } catch {
            guard let customError = error as? CustomError else {
                return
            }
            completion(.failure(customError))
        }
    }
}
