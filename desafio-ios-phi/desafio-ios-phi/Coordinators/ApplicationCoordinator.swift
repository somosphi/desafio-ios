//
//  ApplicationCoordinator.swift
//  desafio-ios-phi
//
//  Created by Lidiane Gomes on 27/04/21.
//

import Foundation
import UIKit

class ApplicationCoordinator: Coordinator {
    var navigationController: UINavigationController
    var statementCoordinator: StatementCoordinator?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let childCoordinator = StatementCoordinator(navigationController: navigationController)
        childCoordinator.start()
        self.statementCoordinator = childCoordinator
    }
}
