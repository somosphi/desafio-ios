//
//  QueryService.swift
//  Desafio-iOS
//
//  Created by Alex Freitas on 03/05/21.
//

import Foundation

enum NetworkError: Error {
    case unexpectedError
    case decodingError
}

class QueryService {
    let defaultSession = URLSession(configuration: .default)
    let baseURL = "https://desafio-mobile-bff.herokuapp.com"

    func getAmount(completion: @escaping (Result<Double, NetworkError>) -> Void) {
        guard let url = URL(string: baseURL + "/myBalance") else { return }
        var request = URLRequest(url: url)

        request.addValue("eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiaWF0IjoxNTE2MjM5MDIyfQ.SflKxwRJSMeKKF2QT4fwpMeJf36POk6yJV_adQssw5c",
                         forHTTPHeaderField: "token")

        defaultSession.dataTask(with: request) { data, response, error in
            if let _ = error {
                completion(.failure(.unexpectedError))
            } else if let data = data,
                      let response = response as? HTTPURLResponse,
                      response.statusCode == 200 {
                do {
                    let decoder = JSONDecoder()
                    let amountInfo = try decoder.decode(AmountInfo.self, from: data)
                    completion(.success(amountInfo.amount))
                } catch {
                    completion(.failure(.decodingError))
                }
            }
        }.resume()
    }
}

struct AmountInfo: Codable {
    let amount: Double
}
