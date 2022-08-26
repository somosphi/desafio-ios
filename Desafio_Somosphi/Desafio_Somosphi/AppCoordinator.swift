//
//  AppCoordinator.swift
//  Desafio_Somosphi
//
//  Created by Suh on 04/08/22.
//

import UIKit

class AppCoordinator: Coordinator {

    var navigationController: UINavigationController
    private var window: UIWindow?
    private var childCoordinator: Coordinator?

    init(navigationController: UINavigationController, window: UIWindow) {
        self.navigationController = navigationController
        self.window = window
    }

    func start() {
        let navigationController = UINavigationController()
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()

        showStatementCoordinator(navigationController)
     //   showDetailCoordinator(navigationController)
    }

    fileprivate func showStatementCoordinator(_ navigationController: UINavigationController) {
        let statementCoordinator = StatementCoordinator(navigationController: navigationController)
        statementCoordinator.start()
        childCoordinator = statementCoordinator
    }

    fileprivate func showDetailCoordinator(_ navigationController: UINavigationController) {
        let detailCoordinator = DetailCoordinator(navigationController: navigationController)
        detailCoordinator.start()
        childCoordinator = detailCoordinator
    }

}
