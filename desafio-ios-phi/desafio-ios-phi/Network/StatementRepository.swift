//
//  StatementRepository.swift
//  desafio-ios-phi
//
//  Created by Lidiane Gomes on 29/04/21.
//

import Foundation
struct StatementRepository {
    static func getMyBalance(completion: @escaping ((Statement?) -> Void)) {
        NetworkManager.request(router: .getMyBalance) { result in
            switch result {
            case .failure(let error):
                print(error)
                completion(nil)
               
            case .success(let data):
                guard let data = data else {
                    completion(nil)
                    return
                }
                let statement: Statement? = (try? JSONDecoder().decode(Statement.self, from: data))
                completion(statement)
            }
        }
    }
    
    static func getMyStatement(limit: Int, offset: Int, completion: @escaping (([Transaction]) -> Void)) {
        NetworkManager.request(router: .getMyStatement(limit: limit, offset: offset)) { result in
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
                    let datas = item.items
                    let transactions = datas.map {Transaction(from: $0)}
                    completion(transactions)
                } else {
                    completion([])
                }
               
            }
        }
    }
    
    static func getMyStatementDetail(transactionID: String, completion: @escaping ((Transaction?) -> Void)) {
        NetworkManager.request(router: .getMyStatementDetail(transactionID: transactionID)) { result in
            switch result {
            case .failure(let error):
                print(error)
                completion(nil)
            case .success(let data):
                guard let data = data else {
                    completion(nil)
                    return
                }
    
                let dataTransaction = (try? JSONDecoder().decode(DecodableTransaction.self, from: data))
                guard let dataTransaction = dataTransaction else {
                    completion(nil)
                    return
                }
                completion(Transaction(from: dataTransaction))
            }
        }
    }
}
