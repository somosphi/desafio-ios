//
//  RequestParser.swift
//  desafio-4all
//
//  Created by Vitor Demenighi on 29/12/20.
//

import Foundation

protocol RequestParserProtocol {
    func parseData<T: Decodable>(data: Data?) -> Result<T, CustomError>
}

extension RequestParserProtocol {
    func parseData<T: Decodable>(data: Data?) -> Result<T, CustomError> {
        
        guard let data = data else {
            return .failure(CustomError.responseDataNil)
        }
        
        do {
            let resultDecode = try JSONDecoder().decodeWithDate(T.self, from: data)
            return .success(resultDecode)
        } catch {
            return .failure(CustomError.failedToDecode)
        }
    }
}

class RequestParser: RequestParserProtocol {}
