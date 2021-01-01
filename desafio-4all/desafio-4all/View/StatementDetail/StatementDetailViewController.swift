//
//  StatementDetailViewController.swift
//  desafio-4all
//
//  Created by Vitor Demenighi on 31/12/20.
//

import UIKit

class StatementDetailViewController: UIViewController {
    
    var viewModel: StatementDetailViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel? = StatementDetailViewModel(delegate: self)
    }
}

extension StatementDetailViewController: StatementDetailViewModelDelegate {
    func didGetStatementDetail(statementDetail: StatementDetail) {
        print(statementDetail.amount)
    }
    
    func failed(message: String) {
        print(message)
    }
}
