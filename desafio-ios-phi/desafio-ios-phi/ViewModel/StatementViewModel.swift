//
//  StatementViewModel.swift
//  desafio-ios-phi
//
//  Created by Lidiane Gomes on 27/04/21.
//

import Foundation

class StatementViewModel: Equatable {
    
    // MARK: - Properties
    private var service: Service
    var isPaginating = false
    private var balance: Balance?
    private var listOfTransactions = [StatementDetailViewModel]()
    
    var amount: String? {
        return balance?.amount?.formattedWithSeparator
    }
    
    var amountDescription: String? {
        guard let doubleValue = balance?.amount else {
            return amount
        }
        
        let description = String(format: "%.2f", doubleValue)
        return "\(description) reais"
    }
    // MARK: - Initialization
    
    init(balance: Balance? = nil, listOfTransactions: [StatementDetailViewModel] = [], service: Service = Service()) {
        self.balance = balance
        self.listOfTransactions = listOfTransactions
        self.service = service
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

// MARK: - Equatable
extension StatementViewModel {
    static func == (lhs: StatementViewModel, rhs: StatementViewModel) -> Bool {
        return lhs.balance == rhs.balance &&
            lhs.listOfTransactions == rhs.listOfTransactions
        
    }
}

// MARK: - Network

extension StatementViewModel {
    
    func getMyBalance(completion: @escaping ((StatementViewModel, NetWorkResponseError?) -> Void)) {
        service.getMyBalance { result in
            
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
        service.getMyStatement(limit: 10, offset: 0) { result in
            
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
        
        service.getMyStatement(limit: limit, offset: offset) { result in
            
            switch result {
            case .success(let statement):
                let newStatements = statement.map {StatementDetailViewModel(statement: $0)}
                self.listOfTransactions += newStatements
                DispatchQueue.main.async {
                    completion(self, newStatements)
                    if pagination {
                        self.isPaginating = false
                    }
                }
                
            case .failure:
                DispatchQueue.main.async {
                    completion(self, [])
                }
            }
            
        }
    }
}
