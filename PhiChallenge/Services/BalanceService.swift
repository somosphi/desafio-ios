//
//  MyBalanceService.swift
//  PhiChallenge
//
//  Created by Felipe Wilke on 11/11/20.
//

import Foundation

import Foundation

final class BalanceService: BalanceServiceInput {
    
    weak var outputBalance: BalanceServiceOutput?

    private let api: APIRequestProtocol
    
    init(api: APIRequestProtocol) {
        self.api = api
    }
    
    //MARK: - MyBalance API Request
    func fetchBalance() {
        
        var urlComponents = URLComponents()
        urlComponents.scheme = Path.scheme
        urlComponents.host = Path.host
        urlComponents.path = Path.Balance
        
        guard let urlString = urlComponents.url?.absoluteString else { return }
        
        api.request(urlString: urlString,
                    method: .get,
                    parameters: nil) { [weak self] (response: Balance) in
            print(response.amount)
            self?.outputBalance?.didUpdateBalanceSuccess(response.amount)
            
        } failure: { [weak self] (error) in
            self?.outputBalance?.didUpdatBalanceFail(error)
        }
    }
}
