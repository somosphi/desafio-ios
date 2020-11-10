//
//  APIRequest.swift
//  PhiChallenge
//
//  Created by Felipe Wilke on 09/11/20.
//

import Foundation

typealias Parameters = [String:Any]

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

protocol APIRequestProtocol {
    func request<T>(
        urlString: String,
        method: HTTPMethod,
        parameters: Parameters?,
        success: @escaping (T)->Void,
        failure: @escaping (Error) -> Void
    ) where T : Decodable
}

final class APIRequest: APIRequestProtocol {
    
    private let logger = APILogger()
    
    func request<T>(
        urlString: String,
        method: HTTPMethod,
        parameters: Parameters?,
        success: @escaping (T)->Void,
        failure: @escaping (Error) -> Void
    ) where T : Decodable
      {
        guard let url = URL(string: urlString) else { return failure(AppError.generic) }
        
        let request = makeURLRequest(
            url: url,
            httpMethod: method,
            parameters: parameters
        )
        
        logger.logRequest(request)
        
        let dataTask = URLSession.shared.dataTask(with: request) { [logger] (data, response, error) in
            guard let response = response else { return failure(AppError.generic) }
            logger.logResponse((data,response,error))
            if response.isValid, let object:T = try? data?.decode(logger: logger) {
                success(object)
            } else {
                failure(AppError.generic)
            }
        }
            dataTask.resume()
    }
    
    private func makeURLRequest(
        url: URL,
        httpMethod: HTTPMethod,
        parameters: Parameters?
    ) -> URLRequest {
        
        var request = URLRequest(
            url: url,
            cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,
            timeoutInterval: 30
        )
        
        request.httpMethod = httpMethod.rawValue
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.setValue(Path.token, forHTTPHeaderField: "token")
        
        if let parameters = parameters {
            let jsonData = try? JSONSerialization.data(withJSONObject: parameters)
            request.httpBody = jsonData
        }
        
        return request
    }
}

private extension URLResponse {
    var isValid: Bool {
        guard let httpResposne = self as? HTTPURLResponse else { return false }
        switch httpResposne.statusCode {
        case 400..<600:
            return false
        default:
            return true
        }
    }
}

private extension Data {
    func decode<T: Decodable>(logger: APILogger) throws -> T {
        do {
            let object = try JSONDecoder().decode(T.self, from: self)
            return object
        } catch let error {
            logger.logError(error)
            throw AppError.generic
        }
    }
}
