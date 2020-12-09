//
//  StatementViewModel.swift
//  desafio-ios
//
//  Created by Alexandre Scheer Bing on 07/12/20.
//

import Foundation
import RxSwift

final class StatementViewModel{
    
    let service: NetworkService

    init(service: NetworkService = NetworkService()) {
        self.service = service
        //service.fetchCurrentAmmount()
        //service.fetchMyStatement(offset: 0)
        //service.fetchTransferDetails(id: "49E27207-F3A7-4264-B021-0188690F7D43")
    }
    
    func fetchAmmount() -> Observable<String>{
        service.fetchCurrentAmmount().map{
            String(format: "%.2f", $0.amount)
        }
    }
    
    func fetchStatement(offset: Int) -> Observable<StatementList> {
        service.fetchMyStatement(offset: offset)
    }
    
    
}
