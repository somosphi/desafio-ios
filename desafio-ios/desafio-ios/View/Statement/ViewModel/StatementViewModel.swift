//
//  StatementViewModel.swift
//  desafio-ios
//
//  Created by Alexandre Scheer Bing on 07/12/20.
//

import Foundation
import RxSwift

final class StatementViewModel{
    
    let service = NetworkService()

    init() {
        service.fetchCurrentAmmount()
        service.fetchMyStatement(offset: 0)
    }
}
