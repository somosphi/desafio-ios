//
//  StatementDetailViewModel.swift
//  desafio-ios-phi
//
//  Created by Lidiane Gomes on 27/04/21.
//

import Foundation

class StatementDetailViewModel {
    
    // MARK: - Properties
    private var service: Service
    private var statement: Statement?
    
    var uuid: String {
        return statement?.uuid ?? ""
    }
    
    var date: String? {
        let date = statement?.date?.toDate
        return date?.toString
    }
    
    var dateResume: String? {
        let date = statement?.date?.toDate
        return date?.toShortString
    }
    
    var amount: String? {
        guard let value = statement?.amount?.formattedWithSeparator else {
            return nil
        }
        return "R$ \(value)"
    }
    
    var description: String? {
        return statement?.description
    }
    
    var type: TransactionType? {
        return TransactionType(rawValue: statement?.type ?? "")
    }
    
    var userName: String? {
        if let from = statement?.from, statement?.sentTo == nil {
            return from
        } else if let sentTo = statement?.sentTo, statement?.from == nil {
            return sentTo
        }
        return nil
    }
    
    var bankName: String? {
        return statement?.bankName
    }
    
    var authentication: String? {
        return statement?.authentication
    }
    
    // MARK: - Initialization
    
    init(statementDetailViewModel: StatementDetailViewModel, service: Service = Service()) {
        self.service = service
        self.statement = statementDetailViewModel.statement
    }
    
    init(statement: Statement?, service: Service = Service()) {
        self.service = service
        self.statement = statement
    }
    
}

// MARK: - Network

extension StatementDetailViewModel {
    func get(uuid: String, completion :@escaping ((StatementDetailViewModel, NetWorkResponseError?) -> Void)) {
        service.getMyStatementDetail(transactionID: uuid) { result in
            
            switch result {
            case .failure(let error):
                DispatchQueue.main.async {
                    completion(self, error)
                }
                
            case .success(let statement):
                self.statement = statement
                DispatchQueue.main.async {
                    completion(self, nil)
                }
            }
        }
    }
}

// MARK: - Conforms to the Hashable

extension StatementDetailViewModel: Hashable {
    
    static func == (lhs: StatementDetailViewModel, rhs: StatementDetailViewModel) -> Bool {
        lhs.uuid == rhs.uuid
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(uuid)
    }
    
}
