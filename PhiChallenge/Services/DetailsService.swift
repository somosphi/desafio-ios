//
//  DetailsService.swift
//  PhiChallenge
//
//  Created by Felipe Wilke on 11/11/20.
//

import Foundation

final class DetailsService: DetailsServiceInput {
    
    weak var outputDetails: DetailsServiceOutput?
    
    private let api: APIRequestProtocol
    
    init(api: APIRequestProtocol) {
        self.api = api
    }
    
    //MARK: - MyStatement details API Request
    func fetchStatementID(id: String) {
    
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "desafio-ios-phi-bff.herokuapp.com"
        urlComponents.path = "/myStatement/detail/" + id
        
        guard let urlString = urlComponents.url?.absoluteString else { return }
        
        api.request(urlString: urlString,
                    method: .get,
                    parameters: nil) { [weak self] (response: Items) in
            self?.outputDetails?.didUpdateDetailsSuccess(response)
        } failure: { [weak self] (error) in
            self?.outputDetails?.didUpdatDetailsFail(error)
        }
    }
}
