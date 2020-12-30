//
//  HomeViewModel.swift
//  desafio-4all
//
//  Created by Vitor Demenighi on 29/12/20.
//

import Foundation

protocol HomeViewModelDelegate {
    func didGetStatement(statement: Statement)
    func didGetBalance(balance: Balance)
    func didGetStatementDetail(statementDetail: StatementDetail)
    func failed(message: String)
}

class HomeViewModel {
    
    let network: NetworkWorker
    let delegate: HomeViewModelDelegate
    
    init(network: NetworkWorker = NetworkWorker(), delegate: HomeViewModelDelegate) {
        self.network = network
        self.delegate = delegate
    }
    
    func getMyStatement(page: Int){
        let completion: (Result<Statement, CustomError>) -> Void = { result in
            switch result {
            case .success(let statement):
                self.delegate.didGetStatement(statement: statement)
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
    
    func getStatementDetail(id: String){
        let completion: (Result<StatementDetail, CustomError>) -> Void = { result in
            switch result {
            case .success(let statementDetail):
                self.delegate.didGetStatementDetail(statementDetail: statementDetail)
                break
            case .failure(let error):
                self.delegate.failed(message: error.localizedDescription)
                break
            }
        }
        
        network.performGenericRequest(endPoint: .statementDetail(id: id), completion: completion)
    }
}
