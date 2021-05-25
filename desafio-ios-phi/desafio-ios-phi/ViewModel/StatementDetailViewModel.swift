//
//  StatementDetailViewModel.swift
//  desafio-ios-phi
//
//  Created by Lidiane Gomes on 27/04/21.
//  swiftlint:disable cyclomatic_complexity

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
    
    var dateDescription: String? {
        let values = date?.split(separator: "/")
        guard let day = values?[0], let month = values?[1],
              let monthValue = Int(month), let year = values?[2] else {
            return nil
        }
        
        return "\(day) de \(getMonthDescription(month: monthValue)) de \(year)"
    }
    
    var dateResume: String? {
        let date = statement?.date?.toDate
        return date?.toShortString
    }
    
    var dateResumeDescription: String? {
        let values = dateResume?.split(separator: "/")
        guard let day = values?[0], let month = values?[1], let monthValue = Int(month) else {
            return nil
        }
        
        return "\(day) de \(getMonthDescription(month: monthValue))"
    }
    
    var amount: String? {
        return statement?.amount?.formattedWithSeparator
    }
    
    var amountDescription: String? {
        guard let doubleValue = statement?.amount else {
            return amount
        }
        
        let description = String(format: "%.2f", doubleValue)
        return "\(description) reais"
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
    
    private func getMonthDescription(month: Int) -> String {
         switch month {
         case 1:
             return "Janeiro"
         case 2:
             return "Fevereiro"
         case 3:
             return "Março"
         case 4:
             return "Abril"
         case 5:
             return "Maio"
         case 6:
             return "Junho"
         case 7:
             return "Julho"
         case 8:
             return "Agosto"
         case 9:
             return "Setembro"
         case 10:
             return "Outubro"
         case 11:
             return "Novembro"
         default:
             return "Dezembro"
         }
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
