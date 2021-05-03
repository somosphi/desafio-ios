//
//  StatementDetailViewController.swift
//  desafio-ios-phi
//
//  Created by Lidiane Gomes on 27/04/21.
//

import UIKit

class StatementDetailViewController: UIViewController {
    var transactionId: String
    var statementDetailViewModel: StatementDetailViewModel
    
    init(transactionId: String) {
        self.transactionId = transactionId
        statementDetailViewModel = StatementDetailViewModel(transactionId: transactionId)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadViewModel()
    }

    private func loadViewModel() {
        self.statementDetailViewModel.get(transactionId: transactionId) { statementViewModel in
            self.statementDetailViewModel = statementViewModel
        }
        
    }
}
