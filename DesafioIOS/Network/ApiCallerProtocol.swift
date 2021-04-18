//
//  ApiCallerProtocol.swift
//  DesafioIOS
//
//

import Foundation

enum APIError: Error {
    case failedToGetMyBalance
    case failedToGetMyStatement
    case failedToGetMyStatementDetail
    case wrongURL
}

protocol ApiCallerProtocol{
    func fetchMyBalance(completion : @escaping (Result<MyBalanceResponse,Error>) -> Void)
    
    func fetchMyStatement(numberOfItems: Int, offset: Int, completion : @escaping (Result<MyStatetementsResponse,Error>) -> Void)
    
    func fetchMyStatementDetail(id: String, completion : @escaping (Result<MyStatetementDetailResponse,Error>) -> Void)
    
}
