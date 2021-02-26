//
//  StatementDetailViewModel.swift
//  desafio-phi
//
//  Created by Marcus Vinicius Vieira Badiale on 26/02/21.
//

final class StatementDetailViewModel {
    
    // MARK: - Private variables
    private let coordinator: Coordinator
    private let service = WebService()
    
    // MARK: - Internal variables
    var statementId: String
    var statement: Statement
    
    // MARK: - Init
    init(coordinator: Coordinator, statementId: String) {
        self.coordinator = coordinator
        self.statement = Statement()
        self.statementId = statementId
    }
}

extension StatementDetailViewModel {
    func getStatement(completion: @escaping (Result<Statement?, NetworkError>) -> Void) {
        service.get(resource: Statement.statement(withId: statementId)) { response in
            completion(response)
        }
    }
}
