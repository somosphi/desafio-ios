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

//        guard let url = URL(string: baseURL + "/myBalance") else { return }
        let url = URL(string: baseURL + route)
        var request = URLRequest(url: url!) // evitar forçar, fazer o unwrap da url

        request.addValue("eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiaWF0IjoxNTE2MjM5MDIyfQ.SflKxwRJSMeKKF2QT4fwpMeJf36POk6yJV_adQssw5c",
                         forHTTPHeaderField: "token")
        return request
    }

    func getAmount(completion: @escaping (Result<Double, NetworkError>) -> Void) {
        defaultSession.dataTask(with: requestConfiguration(for: "/myBalance")) { data, response, error in
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

    func getTransactions() {
        
    }

}

struct AmountInfo: Codable {
    let amount: Double
}

struct StatementInfo: Codable {
    let createdAt: String
    let id: String
    let amount: Double
    let bankName: String
    let from: String
    let to: String
    let description: String
    let tType: String

    /*
     "createdAt": "2020-10-22T03:00:00Z",
     "id": "E79E0C9A-46AE-4DBA-82F5-D0BACC53F6CF",
     "amount": 1807,
     "to": "David Bond",
     "description": "Transferência realizada",
     "tType": "TRANSFEROUT"

     "createdAt": "2020-10-16T03:00:00Z",
     "id": "241A26A1-B2AF-4C94-94FE-45EAD7C52BF4",
     "amount": 1479,
     "to": "Roger Windu",
     "description": "Transferência recebida",
     "tType": "TRANSFERIN"

     "amount": 1565,
     "from": "Arthur Hunt",
     "bankName": "Banco Phi",
     "id": "0244F0E3-DBFF-4C80-A388-33C13C87529C",
     "tType": "TRANSFERIN",
     "createdAt": "2020-10-11T03:00:00Z",
     "description": "Transferência recebida"

     DETALHE DA TRANSAÇÃO:
     "amount": 1615,
     "id": "49E27207-F3A7-4264-B021-0188690F7D43",
     "authentication": "15BA0BB3-EFDB-44E9-99BA-3D0F8725C0E3",
     "tType": "PIXCASHIN",
     "createdAt": "2020-11-19T03:00:00Z",
     "to": "Karen Amidala",
     "description": "Transferência PIX recebida"
     */
}
