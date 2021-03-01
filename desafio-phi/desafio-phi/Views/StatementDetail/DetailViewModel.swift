//
//  StatementDetailViewModel.swift
//  desafio-phi
//
//  Created by Marcus Vinicius Vieira Badiale on 26/02/21.
//

struct StatementDetail {
    let title: String
    let description: String
}

final class StatementDetailViewModel {
    
    // MARK: - Private variables
    private let coordinator: Coordinator
    private let service = WebService()
    private var statementId: String
    
    // MARK: - Internal variablel
    var statement: Statement
    var statementDetailArray: [StatementDetail]
    
    // MARK: - Init
    init(coordinator: Coordinator, statementId: String) {
        self.coordinator = coordinator
        self.statement = Statement()
        self.statementDetailArray = []
        self.statementId = statementId
    }
}

extension StatementDetailViewModel {
    
    //MARK: - Internal methods

    func getStatement(completion: @escaping (Result<Statement?, NetworkError>) -> Void) {
        service.get(resource: Statement.statement(withId: statementId)) { response in
            completion(response)
        }
    }
    
    func setupDetailArray() {
        
        statementDetailArray.append(StatementDetail(title: "Tipo de movimentação", description: statement.description))
        statementDetailArray.append(StatementDetail(title: "Valor", description: "R$ \(statement.value)"))
        
        statementDetailArray.append(StatementDetail(title: "Recebedor",
                                                    description: statement.to ?? "-----------"))
        
        statementDetailArray.append(StatementDetail(title: "Instituição bancaria",
                                                    description: statement.bankName ?? "-----------"))
        
        statementDetailArray.append(
            StatementDetail(title: "Data/Hora",
                            description: statement.createdAt.formatDate(inputSymbols: "yyyy-MM-dd'T'HH:mm:ss'Z'",
                                                                        outputSymbols: "dd/MM/yyyy - HH:mm:ss"))
        )
        
        statementDetailArray.append(StatementDetail(title: "Autenticação",
                                                    description: statement.authentication ?? "-----------"))
    }
    
    //MARK: - Private methods
}
