//
//  StatementViewModelMockData.swift
//  desafio-ios-phiTests
//
//  Created by Lidiane Gomes on 18/05/21.
//

import Foundation
@testable import desafio_ios_phi

struct StatementViewModelMockData {
    static let shared = StatementViewModelMockData()
    let statementExemple1: Statement  = Statement(uuid: "E79E0C9A-46AE-4DBA-82F5-D0BACC53F6C",
                                   date: "2020-10-22T03:00:00Z", amount: 1807,
                                   description: "Transferência realizada",
                                   type: "TRANSFEROUT",
                                   sentTo: "David Bond",
                                   from: nil,
                                   bankName: "Banco Phi",
                                   authentication: "15BA0BB3-EFDB-44E9-88BB-3D0F8725C0E3")
    
    let statementExemple2: Statement  = Statement(uuid: "E79E0C9A-46AE-4DBA-82F5-D0BACC53F6C",
                                   date: "2020-10-22T03:00:00Z", amount: 1807,
                                   description: "Transferência realizada",
                                   type: "TRANSFEROUT",
                                   sentTo: nil,
                                   from: "David Bond",
                                   bankName: "Banco Phi",
                                   authentication: "15BA0BB3-EFDB-44E9-88BB-3D0F8725C0E3")
    
    let statementNilExemple: Statement  = Statement(uuid: nil,
                                   date: nil, amount: nil,
                                   description: nil,
                                   type: nil,
                                   sentTo: nil,
                                   from: nil,
                                   bankName: nil,
                                   authentication: nil)
    
    func listOfTransactions() -> [StatementDetailViewModel] {
     return [StatementDetailViewModel(statement: statementExemple1),
             StatementDetailViewModel(statement: statementExemple2)]
   }
}
