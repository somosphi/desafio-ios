//
//  StatementViewModel.swift
//  desafio-ios
//
//  Created by Gustavo Igor Gonçalves Travassos on 12/01/21.
//

import Foundation

// MARK: - Class

final class StatementViewModel {
    
    // MARK: - Private variables
    
    private let coordinator: Coordinator
    private let service = Service()
    
    // MARK: - Initializers
    
    init(coordinator: Coordinator) {
        self.coordinator = coordinator
    }
}

extension StatementViewModel {
    
    // MARK: - Internal methods
    
    func getBalance(completion: @escaping (Balance) -> Void) {
        service.getBalance() { response, error in
            completion(response)
            print(response)
            print(error)
        }
    }
    
    func getStatementList(completion: @escaping (StatementArray) -> Void) {
        service.getStatementList(offset: 100) { response, error in
            completion(response)
            print(response)
            print(error)
        }
    }
}
