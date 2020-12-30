//
//  RequestTestsData.swift
//  desafio-4all
//
//  Created by Vitor Demenighi on 29/12/20.
//

import Foundation

protocol RequestTestsDataProtocol: ValidData, InvalidData {}

protocol ValidData {
    var testID: String { get }
    var validBalanceObject: Data? { get }
    var validStatementObject: Data? { get }
    var validStatementDetailObject: Data? { get }
    var validEmptyItemsArray: Data? { get }
}

protocol InvalidData {
    var invalidBalanceObject: Data? { get }
    var invalidStatementObject: Data? { get }
    var invalidStatementDetailObject: Data? { get }
}

extension ValidData {
    
    var testID: String { return "49E27207-F3A7-4264-B021-0188690F7D43" }
    
    var validBalanceObject: Data? {
        """
            {
                "amount": 1345
            }
            """.data(using: .utf8)
    }
    
    var validStatementObject: Data? {
            """
            {
                "items": [{
                        "createdAt": "2020-10-22T03:00:00Z",
                        "id": "E79E0C9A-46AE-4DBA-82F5-D0BACC53F6CF",
                        "amount": 1807,
                        "to": "David Bond",
                        "description": "Transferência realizada",
                        "tType": "TRANSFEROUT"
                    },
                    {
                        "createdAt": "2020-10-16T03:00:00Z",
                        "id": "241A26A1-B2AF-4C94-94FE-45EAD7C52BF4",
                        "amount": 1479,
                        "to": "Roger Windu",
                        "description": "Transferência recebida",
                        "tType": "TRANSFERIN"
                    },
                    {
                        "amount": 1565,
                        "from": "Arthur Hunt",
                        "bankName": "Banco Phi",
                        "id": "0244F0E3-DBFF-4C80-A388-33C13C87529C",
                        "tType": "TRANSFERIN",
                        "createdAt": "2020-10-11T03:00:00Z",
                        "description": "Transferência recebida"
                    }
            ]}
            """.data(using: .utf8)
    }
    
    var validStatementDetailObject: Data? {
            """
            {
                "amount": 1615,
                "id": "49E27207-F3A7-4264-B021-0188690F7D43",
                "authentication": "15BA0BB3-EFDB-44E9-99BA-3D0F8725C0E3",
                "tType": "PIXCASHIN",
                "createdAt": "2020-11-19T03:00:00Z",
                "to": "Karen Amidala",
                "description": "Transferência PIX recebida"
            }
            """.data(using: .utf8)
    }
    
    var validEmptyItemsArray: Data? {
            """
            {
                "items": []
            }
            """.data(using: .utf8)
    }
}

extension InvalidData {
    var invalidBalanceObject: Data? {
        """
            {
                "amount": "234"
            }
            """.data(using: .utf8)
    }
    
    var invalidStatementObject: Data? {
        """
            {
                "items": [{
                        "createdAt": "2020-10-22T03:00:00Z",
                        "amount": 1807,
                        "to": "David Bond",
                        "vdescription": "Transferência realizada",
                        "tType": "TRANSFEROUT"
                    },
                    {
                        "createdAt": "2020-10-16T03:00:00Z",
                        "id": "241A26A1-B2AF-4C94-94FE-45EAD7C52BF4",
                        "amount": 1479,
                        "to": "Roger Windu",
                        "description": "Transferência recebida",
                        "tType": "TRANSFERIN"
                    },
                    {
                        "amount": 1565,
                        "from": "Arthur Hunt",
                        "bankName": "Banco Phi",
                        "id": "0244F0E3-DBFF-4C80-A388-33C13C87529C",
                        "tType": "TRANSFERIN",
                        "createdAt": "2020-10-11T03:00:00Z",
                        "description": "Transferência recebida"
                    }
            ]}
            """.data(using: .utf8)
    }
    
    var invalidStatementDetailObject: Data? {
        """
            {
                "amount": 1615,
                "id": "49E27207-F3A7-4264-B021-0188690F7D43",
                "authentication": "15BA0BB3-EFDB-44E9-99BA-3D0F8725C0E3",
                "tType": 2,
                "createdAt": "2020-11-19T03:00:00Z",
                "toUser": "Karen Amidala",
                "description": "Transferência PIX recebida"
            }
            """.data(using: .utf8)
    }
}
