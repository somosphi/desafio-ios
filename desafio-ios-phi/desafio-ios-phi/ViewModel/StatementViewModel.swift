//
//  StatementViewModel.swift
//  desafio-ios-phi
//
//  Created by Lidiane Gomes on 27/04/21.
//

import Foundation
class StatementViewModel {
    
    // MARK: - Properties
    
    var isPaginating = false
    private var balance: Balance?
    private var listOfTransactions = [StatementDetailViewModel]()
    
    var amount: String {
        guard let value = balance?.amount else {
            return ""
        }
        return value.formattedWithSeparator
    }
    
    // MARK: - Functions
    
    func getAllTransactions() -> [StatementDetailViewModel] {
        return listOfTransactions
    }
    
    func getStatementDetail(for index: Int) -> StatementDetailViewModel? {
        
        if listOfTransactions.count > index {
            return self.listOfTransactions[index]
        }
        return nil
    }
}

// MARK: - Network

extension StatementViewModel {
    
    func getMyBalance(completion: @escaping ((StatementViewModel, NetWorkResponseError?) -> Void)) {
        Service.getMyBalance { result in
            
            switch result {
            case .success(let balance):
                self.balance = balance
                DispatchQueue.main.async {
                    completion(self, nil)
                }
                
            case .failure(let error):
                DispatchQueue.main.async {
                    completion(self, error)
                }
            }
        }
    }
    
    func getStatement(completion :@escaping ((StatementViewModel, NetWorkResponseError?) -> Void)) {
        Service.getMyStatement(limit: 10, offset: 0) { result in
            
            switch result {
            case .success(let statement):
                self.listOfTransactions = statement.map {StatementDetailViewModel(statement: $0)}
                DispatchQueue.main.async {
                    completion(self, nil)
                }
                
            case .failure(let error):
                DispatchQueue.main.async {
                    completion(self, error)
                }
            }
            
        }
    }
    
    func getStatementWithPagination(pagination: Bool = false,
                                    limit: Int = 10,
                                    offset: Int = 0,
                                    completion :@escaping (StatementViewModel, [StatementDetailViewModel]) -> Void) {
        if pagination {
            isPaginating = true
        }
        Service.getMyStatement(limit: limit, offset: offset) { result in
            
            switch result {
            case .success(let statement):
                let newStatements = statement.map {StatementDetailViewModel(statement: $0)}
                self.listOfTransactions += newStatements
                completion(self, newStatements)
                if pagination {
                    self.isPaginating = false
                }
                
            case .failure:
                DispatchQueue.main.async {
                    completion(self, [])
                }
            }
            
        }
    }
}
