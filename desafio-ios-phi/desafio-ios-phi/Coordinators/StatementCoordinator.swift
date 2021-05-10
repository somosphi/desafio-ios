//
//  StatementCoordinator.swift
//  desafio-ios-phi
//
//  Created by Lidiane Gomes on 27/04/21.
//

import Foundation
import UIKit

class StatementCoordinator: Coordinator {
    var navigationController: UINavigationController
    private var statementViewController: StatementViewController
    private var statementDetailCoordinator: StatementDetailCoordinator?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.statementViewController = StatementViewController()
    }
    
    func start() {
        statementViewController.coordinator = self
        navigationController.pushViewController(statementViewController, animated: true)
    }
    
    func startStatementDetail(statementDetailViewModel: StatementDetailViewModel) {
        let childCoordinator = StatementDetailCoordinator(navigationController: navigationController,
                                                          statementDetailViewModel: statementDetailViewModel)
        childCoordinator.start()
        self.statementDetailCoordinator = childCoordinator
    }
}
