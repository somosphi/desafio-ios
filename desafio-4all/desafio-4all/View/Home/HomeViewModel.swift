//
//  HomeViewModel.swift
//  desafio-4all
//
//  Created by Vitor Demenighi on 29/12/20.
//

import Foundation

protocol HomeViewModelDelegate {
    func didGetStatement()
    func didGetBalance(balance: Balance)
    func failed(message: String)
}

class HomeViewModel {
    
    // MARK: - Variables
    
    let network: NetworkWorker
    let delegate: HomeViewModelDelegate
    
    var items: [Item] = []
    
    // MARK: - Initialization
    
    init(network: NetworkWorker = NetworkWorker(), delegate: HomeViewModelDelegate) {
        self.network = network
        self.delegate = delegate
    }
    
    // MARK: - Functions
    
    func getMyStatement(page: Int){
        let completion: (Result<Statement, CustomError>) -> Void = { result in
            switch result {
            case .success(let resultStatement):
                self.items.append(contentsOf: resultStatement.items)
                self.delegate.didGetStatement()
                break
            case .failure(let error):
                self.delegate.failed(message: error.localizedDescription)
                break
            }
        }
        
        network.performGenericRequest(endPoint: .myStatement(offset: page), completion: completion)
    }
    
    func getMyBalance(){
        let completion: (Result<Balance, CustomError>) -> Void = { result in
            switch result {
            case .success(let balance):
                self.delegate.didGetBalance(balance: balance)
                break
            case .failure(let error):
                self.delegate.failed(message: error.localizedDescription)
                break
            }
        }
        
        network.performGenericRequest(endPoint: .myBalance, completion: completion)
    }
}
