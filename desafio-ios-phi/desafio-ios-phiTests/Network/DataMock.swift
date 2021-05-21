//
//  DataMock.swift
//  desafio-ios-phiTests
//
//  Created by Lidiane Gomes on 19/05/21.
//

import Foundation
@testable import desafio_ios_phi

struct DataMock {
    
    static let balance = Balance(amount: 1250)
    
    static let listOfStatement: [Statement] = [
        Statement(uuid: "E79E0C9A-46AE-4DBA-82F5-D0BACC53F6CF", date: "2020-10-22T03:00:00Z",
                  amount: 1807, description: "Transferência realizada", type: "TRANSFEROUT",
                  sentTo: "David Bond", from: nil, bankName: nil, authentication: nil),
        
        Statement(uuid: "241A26A1-B2AF-4C94-94FE-45EAD7C52BF4", date: "2020-10-16T03:00:00Z",
                  amount: 1479, description: "Transferência recebida", type: "TRANSFERIN",
                  sentTo: "Roger Windu", from: nil, bankName: nil, authentication: nil),
        
        Statement(uuid: "0244F0E3-DBFF-4C80-A388-33C13C87529C", date: "2020-10-11T03:00:00Z",
                  amount: 1565, description: "Transferência recebida", type: "TRANSFERIN",
                  sentTo: nil, from: "Arthur Hunt", bankName: "Banco Phi", authentication: nil)
        
    ]
   
    static let statementDetail = Statement(uuid: "49E27207-F3A7-4264-B021-0188690F7D43",
                                           date: "2020-11-19T03:00:00Z", amount: 1615,
                                           description: "Transferência PIX recebida",
                                           type: "PIXCASHIN", sentTo: "Karen Amidala",
                                           from: nil, bankName: nil,
                                           authentication: "15BA0BB3-EFDB-44E9-99BA-3D0F8725C0E3")
}
