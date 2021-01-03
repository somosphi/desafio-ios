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
    
    // MARK: - Variables
    
    let network: NetworkWorker
    let delegate: StatementDetailViewModelDelegate
    
    let statementId: String
    var bankName: String = StringConstants.emptyBankName
    
    // MARK: - Initialization
    
    init(network: NetworkWorker = NetworkWorker(), delegate: StatementDetailViewModelDelegate, statementId: String) {
        self.network = network
        self.delegate = delegate
        self.statementId = statementId
    }
    
    // MARK: - Functions
    
    func getStatementDetail(){
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
        
        network.performGenericRequest(endPoint: .statementDetail(id: statementId), completion: completion)
    }
    
}
