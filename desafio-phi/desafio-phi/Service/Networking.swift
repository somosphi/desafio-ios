//
//  Networking.swift
//  desafio-phi
//
//  Created by Marcus Vinicius Vieira Badiale on 25/02/21.
//

import Foundation

enum NetworkError: Error {
    case decodingError
    case domainError
    case urlError
}

struct Resource<T> {
    let url: URL
    let parse: (Data) -> T?
}

final class WebService {
    
    private let token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiaWF0IjoxNTE2MjM5MDIyfQ.SflKxwRJSMeKKF2QT4fwpMeJf36POk6yJV_adQssw5c"
    
    func get<T>(resource: Resource<T>, completion: @escaping (Result<T?, NetworkError>) -> () ) {
        
        var urlRequest = URLRequest(url: resource.url)
        urlRequest.setValue(token, forHTTPHeaderField: "token")
        
        URLSession.shared.dataTask(with: urlRequest) { data, result, error in
            
            if let data = data {
                DispatchQueue.main.async {
                    completion(.success(resource.parse(data)))
                }
            } else {
                completion(.failure(.domainError))
            }
            
        }.resume()
    }
}
