//
//  StatementDetailViewModel.swift
//  Desafio-iOS
//
//  Created by Alex Freitas on 25/05/21.
//

import Foundation
import UIKit

class StatementDetailViewModel: NSObject {
    private var service: QueryService = QueryService()

    private(set) var statementInfo: StatementInfo! {
        didSet {
            self.bindViewModelToController()
        }
    }

    private(set) var statementDetail: StatementDetail! {
        didSet {
            self.bindViewModelToController()
        }
    }

    var bindViewModelToController: (() -> Void) = {}

    override init() {
        super.init()
        getData()
    }

    func getData() {
//        service.getDetail(transfer: statementInfo.id) { result in
//            switch result {
//            case .failure(let error):
//                print(error)
//            case .success(let statementDetail):
//                DispatchQueue.main.async {
//                    self.statementDetail = statementDetail
//                }
//            }
//        }
    }
}
