//
//  MyStatementService.swift
//  PhiChallenge
//
//  Created by Felipe Wilke on 11/11/20.
//

import Foundation

final class StatementService: StatementServiceInput {

    weak var outputStatement: StatementServiceOutput?
    
    private let api: APIRequestProtocol
    
    init(api: APIRequestProtocol) {
        self.api = api
    }
    
    //MARK: - MyStatement API Request
    func fetchStatement(offset: String) {
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "desafio-ios-phi-bff.herokuapp.com"
        urlComponents.path = "/myStatement/10/" + offset
               
        guard let urlString = urlComponents.url?.absoluteString else { return }
        
        api.request(urlString: urlString,
                    method: .get,
                    parameters: nil) { [weak self] (response: Statement) in
            self?.outputStatement?.didUpdateStatementSuccess(response.items)
        } failure: { [weak self] (error) in
            self?.outputStatement?.didUpdatStatementFail(error)
        }
    }
}
