//
//  Service.swift
//  desafio-ios-phi
//
//  Created by Lidiane Gomes on 29/04/21.
//

import Foundation
struct Service {
   static func getMyBalance(completion: @escaping ((Balance?) -> Void)) {
        NetworkManager.request(router: .myBalance) { result in
            switch result {
            case .failure(let error):
                print(error)
                completion(nil)
               
            case .success(let data):
                guard let data = data else {
                    completion(nil)
                    return
                }
                let statement: Balance? = (try? JSONDecoder().decode(Balance.self, from: data))
                completion(statement)
            }
        }
    }
    
   static func getMyStatement(limit: Int, offset: Int, completion: @escaping (([Statement]) -> Void)) {
        NetworkManager.request(router: .mySatatemet(limit: limit, offset: offset)) { result in
            switch result {
            case .failure(let error):
                print(error)
                completion([])
            case .success(let data):
                guard let data = data else {
                    completion([])
                    return
                }
        
                let item = (try? JSONDecoder().decode(DecodableData.self, from: data))
                if let item = item {
                    completion(item.items)
                } else {
                    completion([])
                }
               
            }
        }
    }
    
   static func getMyStatementDetail(transactionID: String, completion: @escaping ((Statement?) -> Void)) {
        NetworkManager.request(router: .myStatementDetail(transactionID: transactionID)) { result in
            switch result {
            case .failure(let error):
                print(error)
                completion(nil)
            case .success(let data):
                guard let data = data else {
                    completion(nil)
                    return
                }
    
                let dataTransaction = (try? JSONDecoder().decode(Statement.self, from: data))
                completion(dataTransaction)
            }
        }
    }
}
