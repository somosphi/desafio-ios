//
//  StatementCoordinator.swift
//  desafio-ios-phi
//
//  Created by Lidiane Gomes on 27/04/21.
//

import Foundation
import UIKit

class StatementCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    private var statementViewController: StatementViewController?
    private var statementDetailCoordinator: StatementDetailCoordinator?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let statementViewController = StatementViewController()
        statementViewController.coordinator = self
        navigationController.pushViewController(statementViewController, animated: true)
        self.statementViewController = statementViewController
    }
    
    func startDetail() {
        let childCoordinator = StatementDetailCoordinator(navigationController: navigationController)
        childCoordinators.append(childCoordinator)
        childCoordinator.start()
        self.statementDetailCoordinator = childCoordinator
    }
}
