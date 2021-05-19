//
//  NetworkManager.swift
//  desafio-ios-phi
//
//  Created by Lidiane Gomes on 29/04/21.
//

import Foundation

struct NetworkManager: NetworkRequestManager {
    var session: URLSession
    
    init(session: URLSession = URLSession(configuration: .default)) {
        self.session = session
    }
    
    func request(router: Router, completion: @escaping (Result<Data?, NetWorkResponseError>) -> Void) {
        guard let urlRequest = router.urlRequest else {
            completion(.failure(.malformedURLRequest(url: router.url?.absoluteString ?? "nil")))
            return
        }
        
        let dataTask = session.dataTask(with: urlRequest) { data, response, error in
            if let error = error {
                completion(.failure(.requestFailed(description: error.localizedDescription)))
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                return
            }
            
            switch response.statusCode {
            case 200, 201:
                completion(.success(data))
                
            case 400:
                completion(.failure(.badRequest))
                
            case 404:
                completion(.failure(.notFound))
                
            default:
                completion(.failure(.unknownError(statusCode: response.statusCode)))
            }
            
        }
        
        dataTask.resume()
    }
}
