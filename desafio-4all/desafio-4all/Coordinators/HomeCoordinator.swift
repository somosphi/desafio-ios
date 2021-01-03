//
//  HomeCoordinator.swift
//  desafio-4all
//
//  Created by Vitor Demenighi on 31/12/20.
//

import UIKit

class HomeCoordinator {
    
    let presenter: UINavigationController
    
    // MARK: - Initialization
    
    init(presenter: UINavigationController) {
        self.presenter = presenter
    }
    
    // MARK: - Functions
    
    func start(){
        let homeVC = HomeViewController()
        homeVC.navigationItem.hidesBackButton = true
        homeVC.coordinator = self
        
        presenter.navigationBar.isHidden = false
        presenter.pushViewController(homeVC, animated: false)
    }
    
    func goToStatementDetailScreen(statementId: String, bankName: String? = nil){
        let statementDetailVC = StatementDetailViewController(statementId: statementId, bankName: bankName)
        presenter.pushViewController(statementDetailVC, animated: true)
    }
    
}
