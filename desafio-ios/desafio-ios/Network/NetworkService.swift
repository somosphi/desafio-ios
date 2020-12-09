//
//  NetworkService.swift
//  desafio-ios
//
//  Created by Alexandre Scheer Bing on 07/12/20.
//

import Foundation

class NetworkService {
    
    let baseURL = "https://desafio-ios-phi-bff.herokuapp.com"
    let token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiaWF0IjoxNTE2MjM5MDIyfQ.SflKxwRJSMeKKF2QT4fwpMeJf36POk6yJV_adQssw5c"
    
    func fetchCurrentAmmount() {
        var request = URLRequest(url: URL(string: baseURL+"/myBalance")!)
        request.setValue(token, forHTTPHeaderField: "token")
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if response != nil {
                guard let data = data else { return }
                do {
                    let amount = try JSONDecoder().decode(Amount.self, from: data)
                    print(amount)
                }
                catch {
                    print(error)
                }
                
            } else {
                return
            }
        }
        
        task.resume()
    }
    
    func fetchMyStatement(offset: Int){
        var request = URLRequest(url: URL(string: baseURL+"/myStatement/10/\(offset)")!)
        request.setValue(token, forHTTPHeaderField: "token")
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if response != nil {
                guard let data = data else { return }
                do {
                    print(data)
                    let statement = try JSONDecoder().decode(StatementList.self, from: data)
                    print(statement)
                }
                catch {
                    print(error)
                }
                
            } else {
                return
            }
        }
        
        task.resume()
    }
    func fetchTransferDetails(id: String){
        var request = URLRequest(url: URL(string: baseURL+"/myStatement/detail/"+id)!)
        request.setValue(token, forHTTPHeaderField: "token")
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if response != nil {
                guard let data = data else { return }
                do {
                    print(data)
                    let statement = try JSONDecoder().decode(Statement.self, from: data)
                    print(statement)
                }
                catch {
                    print(error)
                }
                
            } else {
                return
            }
        }
        
        task.resume()
    }
}
