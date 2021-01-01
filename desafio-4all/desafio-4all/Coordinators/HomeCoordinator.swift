//
//  HomeCoordinator.swift
//  desafio-4all
//
//  Created by Vitor Demenighi on 31/12/20.
//

import UIKit

class HomeCoordinator {
    
    let presenter: UINavigationController
    
    init(presenter: UINavigationController) {
        self.presenter = presenter
    }
    
    func start(){
        let homeVC = HomeViewController()
        homeVC.navigationItem.hidesBackButton = true
        homeVC.coordinator = self
        
        presenter.navigationBar.isHidden = false
        presenter.pushViewController(homeVC, animated: false)
    }
    
}
