//
//  QueryService.swift
//  Desafio-iOS
//
//  Created by Alex Freitas on 03/05/21.
//

import Foundation

enum NetworkError: Error {
    case badURL
}

class QueryService {
    let defaultSession = URLSession(configuration: .default)

    var dataTask: URLSessionDataTask?
    var errorMessage = ""
    let urlString = "https://desafio-mobile-bff.herokuapp.com/myBalance"

    var amountString = ""

    func getAmount(completion: @escaping (Double) -> Void) {
        dataTask?.cancel()

        let url = URL(string: urlString)!
        var request = URLRequest(url: url)

        request.addValue("eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiaWF0IjoxNTE2MjM5MDIyfQ.SflKxwRJSMeKKF2QT4fwpMeJf36POk6yJV_adQssw5c",
                         forHTTPHeaderField: "token")

        dataTask = defaultSession.dataTask(with: request) { [weak self] data, response, error in
            defer {
                self?.dataTask = nil
            }

            if let error = error {
                self?.errorMessage += "DataTask error: " + error.localizedDescription + "\n"
            } else if let data = data,
                      let response = response as? HTTPURLResponse,
                      response.statusCode == 200 {
                if let result = NSString(data: data, encoding: String.Encoding.utf8.rawValue) as String? {
                    print(result)   // {"amount":1345} remover
                }

                do {
                    let decoder = JSONDecoder()

                    let amountInfo = try decoder.decode(AmountInfo.self, from: data)
                    self?.amountString = String(amountInfo.amount)
                    completion(amountInfo.amount)
                } catch {
                    print("Error \(error)")
                }
            }
        }

        dataTask?.resume()
    }
}

struct AmountInfo: Codable {
    let amount: Double
}
