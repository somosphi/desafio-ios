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
    private let defaultSession = URLSession(configuration: .default)

    private func requestConfiguration(for route: String) -> URLRequest {
        let baseURL = "https://desafio-mobile-bff.herokuapp.com"

        let url = URL(string: baseURL + route)
        var request = URLRequest(url: url!) // evitar forçar, fazer o unwrap da url

        request.addValue("eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiaWF0IjoxNTE2MjM5MDIyfQ.SflKxwRJSMeKKF2QT4fwpMeJf36POk6yJV_adQssw5c",
                         forHTTPHeaderField: "token")
        return request
    }

    func getAmount(completion: @escaping (Result<Double, NetworkError>) -> Void) {
        defaultSession.dataTask(with: requestConfiguration(for: "/myBalance")) { data, response, error in
            if error != nil {
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

    private var isFetchingPage = false
    private var shouldFetchMorePages = true
    private var page: Int = -1

    func getStatement(completion: @escaping (Result<[StatementInfo], NetworkError>) -> Void) {
        if isFetchingPage || !shouldFetchMorePages {
            return
        }

        isFetchingPage = true
        page += 1

        defaultSession.dataTask(with: requestConfiguration(for: "/myStatement/10/\(page)")) { data, response, error
            in
                if error != nil {
                    completion(.failure(.unexpectedError))
                } else if let data = data,
                          let response = response as? HTTPURLResponse,
                          response.statusCode == 200 {
                    do {
                        let decoder = JSONDecoder()
                        let statementInfo = try decoder.decode(Response.self, from: data)
                        completion(.success(statementInfo.items))
                        self.shouldFetchMorePages = !statementInfo.items.isEmpty
                    } catch {
                        completion(.failure(.decodingError))
                    }
                    self.isFetchingPage = false
                }
        }.resume()
    }

    func getDetail(transfer id: String, completion: @escaping (Result<StatementDetail, NetworkError>) -> Void) {
        let detailConfig = "/myStatement/detail/\(id)/"
        defaultSession.dataTask(with: requestConfiguration(for: detailConfig)) { data, response, error
            in
            if error != nil {
                completion(.failure(.unexpectedError))
            } else if let data = data,
                      let response = response as? HTTPURLResponse,
                      response.statusCode == 200 {
                do {
                    let decoder = JSONDecoder()
                    let statementDetail = try decoder.decode(StatementDetail.self, from: data)
                    completion(.success(statementDetail))
                } catch {
                    completion(.failure(.decodingError))
                }
            }
        }.resume()
    }
}
