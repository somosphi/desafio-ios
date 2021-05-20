//
//  Service.swift
//  desafio-ios-phi
//
//  Created by Lidiane Gomes on 29/04/21.
//

import Foundation

struct Service {
    private var networkManager: NetworkManager
    
    init(networkManager: NetworkManager = NetworkManager()) {
        self.networkManager = networkManager
    }
    
    func getMyBalance(completion: @escaping ((Result<Balance?, NetWorkResponseError>) -> Void)) {
        networkManager.request(router: .myBalance) { result in
            switch result {
            case .failure(let error):
                print(error)
                completion(.failure(error))
                
            case .success(let data):
                guard let data = data else {
                    return
                }
                let statement: Balance? = (try? JSONDecoder().decode(Balance.self, from: data))
                completion(.success(statement))
            }
        }
    }
    
    func getMyStatement(limit: Int,
                        offset: Int,
                        completion: @escaping ((Result<[Statement], NetWorkResponseError>) -> Void)) {
        networkManager.request(router: .mySatatemet(limit: limit, offset: offset)) { result in
            switch result {
            case .failure(let error):
                print(error)
                completion(.failure(error))
                
            case .success(let data):
                guard let data = data else {
                    return
                }
                
                let item = (try? JSONDecoder().decode(DecodableData.self, from: data))
                if let item = item {
                    completion(.success(item.items))
                } else {
                    completion(.failure(.decodableDataError))
                    print(NetWorkResponseError.decodableDataError.localizedDescription)
                }
                
            }
        }
    }
    
    func getMyStatementDetail(transactionID: String,
                              completion: @escaping ((Result<Statement?, NetWorkResponseError>) -> Void)) {
        networkManager.request(router: .myStatementDetail(transactionID: transactionID)) { result in
            switch result {
            case .failure(let error):
                print(error)
                completion(.failure(error))
                
            case .success(let data):
                guard let data = data else {
                    return
                }
                
                let statement = (try? JSONDecoder().decode(Statement.self, from: data))
                if statement != nil {
                    completion(.success(statement))
                } else {
                    completion(.failure(.decodableDataError))
                    print(NetWorkResponseError.decodableDataError.localizedDescription)
                }
            }
        }
    }
}
