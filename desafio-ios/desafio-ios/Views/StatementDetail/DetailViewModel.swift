//
//  DetailViewModel.swift
//  desafio-ios
//
//  Created by Gustavo Igor Gonçalves Travassos on 12/01/21.
//

import Foundation

// MARK: - Class

final class DetailViewModel {
    
    // MARK: - Private variables
    
    private let coordinator: Coordinator
    private let service = Service()
    private let id: String
    
    // MARK: - Internal variables
    
    var model: Statement?
    var dataArray: [(title: String, description: String)]
    
    // MARK: - Initializers
    
    init(coordinator: Coordinator, id: String) {
        self.coordinator = coordinator
        self.id = id
        self.dataArray = []
    }
}

extension DetailViewModel {
    
    // MARK: - Internal methods
    
    func getStatementDetail(completion: @escaping (Statement) -> Void) {
        service.getStatementDetail(id: id) { response, error in
            completion(response)
        }
    }
    
    func setupDataArray() {
        guard let model = model else { return }
        
        var amount = "\(String(model.amount).formatToCurrency)"
        amount = amount.replacingOccurrences(of: ".", with: ",")
        
        dataArray.append((title: "Tipo de movimentação", description: model.transferenceType))
        dataArray.append((title: "Tipo de Valor", description: amount))
        
        if let to = model.to {
            dataArray.append((title: "Recebedor", description: to))
        }
        
        if let bankName = model.bankName {
            dataArray.append((title: "Instituição bancária", description: bankName))
        }
        
        dataArray.append((title: "Data/Hora",
                          description: model.createdAt.formatDate(inputSymbols: "yyyy-MM-dd'T'HH:mm:ss'Z'",
                                                                  outputSymbols: "dd/MM/yyyy - HH:mm:ss")))
        
        if let authentication = model.authentication {
            dataArray.append((title: "Autenticação", description: authentication))
        }
    }
}
