//
//  Service.swift
//  desafio-ios
//
//  Created by Gustavo Igor Gonçalves Travassos on 12/01/21.
//

import Foundation

// MARK: - Class

final class Service {
    
    // MARK: - Private variables
    
    private let baseURL = "https://desafio-mobile-bff.herokuapp.com"
    private let token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiaWF0IjoxNTE2MjM5MDIyfQ.SflKxwRJSMeKKF2QT4fwpMeJf36POk6yJV_adQssw5c"
}

extension Service {
    // MARK: - Internal methods
    
    func getBalance() {
        var request = URLRequest(url: URL(string: baseURL + "/myBalance")!)
        request.setValue(token, forHTTPHeaderField: "token")
        
        // TODO: Request
    }
    
    func getStatement(offset: Int) {
        var request = URLRequest(url: URL(string: baseURL + "/myStatement/100/\(offset)")!)
        request.setValue(token, forHTTPHeaderField: "token")
        
        // TODO: Request
    }
    
    func getStatementDetail(id: String) {
        var request = URLRequest(url: URL(string: baseURL + "/myStatement/detail/" + id)!)
        request.setValue(token, forHTTPHeaderField: "token")
        
        // TODO: Request
    }
}
