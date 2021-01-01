//
//  StatementDetailViewModel.swift
//  desafio-4all
//
//  Created by Vitor Demenighi on 31/12/20.
//

import Foundation

protocol StatementDetailViewModelDelegate {
    func didGetStatementDetail(statementDetail: StatementDetail)
    func failed(message: String)
}

class StatementDetailViewModel {
    
    let network: NetworkWorker
    let delegate: StatementDetailViewModelDelegate
    
    init(network: NetworkWorker = NetworkWorker(), delegate: StatementDetailViewModelDelegate) {
        self.network = network
        self.delegate = delegate
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
