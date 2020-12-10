//
//  DetailViewModel.swift
//  desafio-ios
//
//  Created by Alexandre Scheer Bing on 09/12/20.
//

import Foundation
import RxSwift

class DetailViewModel{
    
    let service = NetworkService()
    let id: String
    
    init(id: String) {
        self.id = id
    }
    
    func retrieveAuth() -> Observable<Statement> {
        service.fetchTransferDetails(id: id).map{
            $0
        }
        
    }
}
