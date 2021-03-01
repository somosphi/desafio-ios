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
    var balance: Balance
    var currentStatementPage: Int
    var isPaginating: Bool
    
    // MARK: - Init
    init(coordinator: Coordinator) {
        self.coordinator = coordinator
        self.statements = []
        self.balance = Balance()
        self.currentStatementPage = -1
        self.isPaginating = false
    }
}

extension StatementViewModel {
    
    func getMyBalance(completion: @escaping (Result<Balance?, NetworkError>) -> Void) {
        service.get(resource: Balance.myBalance) { response in
            completion(response)
        }
    }
    
    func getStatementList(offSet: Int ,completion: @escaping (Result<[Statement]?, NetworkError>) -> Void) {
        service.get(resource: StatementResponse.list(with: offSet)) { response in
            completion(response)
        }
    }
    
    func goToDetail(withId id: String) {
        coordinator.routeToStatementDetail(statementId: id)
    }
}
