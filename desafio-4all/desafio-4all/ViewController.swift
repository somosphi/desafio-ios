//
//  ViewController.swift
//  desafio-4all
//
//  Created by Vitor Demenighi on 29/12/20.
//

import UIKit

class ViewController: UIViewController {
    
    var viewModel: HomeViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel = HomeViewModel(delegate: self)
    }

    @IBAction func vaiPokebola(_ sender: Any) {
        viewModel?.getStatementDetail(id: "49E27207-F3A7-4264-B021-0188690F7D43")
    }
}

extension ViewController: HomeViewModelDelegate {
    func didGetStatementDetail(statementDetail: StatementDetail) {
        print(statementDetail.id, "DETAIL")
    }
    
    func didGetBalance(balance: Balance) {
        print(balance.amount, "AMOUNT")
    }
    
    func didGetStatement(statement: Statement) {
        print(statement.items.count, "COUNT")
    }
    
    func failed(message: String) {
        print(message, "ERROR")
    }
}

