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
    
    // MARK: - Initializers
    
    init(coordinator: Coordinator) {
        self.coordinator = coordinator
    }
}

extension DetailViewModel {
    
    // MARK: - Internal methods
    
    func getStatementDetail() {
        service.getStatementDetail(id: "")
    }
}
