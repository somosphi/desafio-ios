//
//  Service.swift
//  desafio-ios
//
//  Created by Gustavo Igor Gonçalves Travassos on 12/01/21.
//

import Foundation

// MARK: - Class

final class Service {
    
    // MARK: - Private variables
    
    private let baseURL = "https://desafio-mobile-bff.herokuapp.com"
    private let token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiaWF0IjoxNTE2MjM5MDIyfQ.SflKxwRJSMeKKF2QT4fwpMeJf36POk6yJV_adQssw5c"
}

extension Service {
    
    // MARK: - Internal methods
    
    func getBalance(completionHandler: @escaping (Balance, Error?) -> Void) {
        var request = URLRequest(url: URL(string: baseURL + "/myBalance")!)
        request.setValue(token, forHTTPHeaderField: "token")
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else { return }
            do {
                let decoder = JSONDecoder()
                let response = try  decoder.decode(Balance.self, from: data)
                completionHandler(response, error)
            }
            catch let error {
                let balance = Balance(amount: 0)
                 completionHandler(balance, error)
            }
        }.resume()
    }
    
    func getStatementList(offset: Int, completionHandler: @escaping (StatementArray, Error?) -> Void) {
        var request = URLRequest(url: URL(string: baseURL + "/myStatement/100/\(offset)")!)
        request.setValue(token, forHTTPHeaderField: "token")
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else { return }
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(StatementArray.self, from: data)
                completionHandler(response, error)
            }
            catch let error {
                let statementArray = StatementArray(items: [])
                 completionHandler(statementArray, error)
            }
        }.resume()
    }
    
    func getStatementDetail(id: String, completionHandler: @escaping (Statement, Error?) -> Void) {
        var request = URLRequest(url: URL(string: baseURL + "/myStatement/detail/" + id)!)
        request.setValue(token, forHTTPHeaderField: "token")
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else { return }
            do {
                let decoder = JSONDecoder()
                let response = try  decoder.decode(Statement.self, from: data)
                completionHandler(response, error)
            }
            catch let error {
                let statement = Statement(createdAt: "",
                                          id: "",
                                          amount: 0.0,
                                          description: "",
                                          tType: "",
                                          to: nil,
                                          from: nil,
                                          bankName: nil,
                                          authentication: nil)
                completionHandler(statement, error)
            }
        }.resume()
    }
}
