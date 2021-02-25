//
//  StatementViewModel.swift
//  desafio-phi
//
//  Created by Marcus Vinicius Vieira Badiale on 25/02/21.
//

import Foundation

final class StatementViewModel {

    // MARK: - Private variables
    private let coordinator: Coordinator
    private let service = WebService()
    
    // MARK: - Internal variables
    var statements: [Statement]
    
    // MARK: - Init
    init(coordinator: Coordinator) {
        self.coordinator = coordinator
        self.statements = []
    }
}

extension StatementViewModel {
    
    func getMyBalance(completion: @escaping (Result<Balance?, NetworkError>) -> Void) {
        service.get(resource: Balance.myBalance) { response in
            completion(response)
        }
    }
    
    func getStatementList(completion: @escaping (Result<[Statement]?, NetworkError>) -> Void) {
        service.get(resource: StatementResponse.statementList) { response in
            completion(response)
        }
    }
}
