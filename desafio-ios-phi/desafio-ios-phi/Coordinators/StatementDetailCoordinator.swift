//
//  StatementDetailCoordinator.swift
//  desafio-ios-phi
//
//  Created by Lidiane Gomes on 27/04/21.
//

import Foundation
import UIKit
class StatementDetailCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    private var statementDetailViewController: StatementDetailViewController?
   
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let statementDetailViewController = StatementDetailViewController()
        statementDetailViewController.coordinator = self
        navigationController.pushViewController(statementDetailViewController, animated: true)
        self.statementDetailViewController = statementDetailViewController
    }
}
