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

        showExtractCoordinator(navigationController)
    }

    fileprivate func showExtractCoordinator(_ navigationController: UINavigationController) {
        let extractCoordinator = ExtractCoordinator(navigationController: navigationController)
        extractCoordinator.start()
        childCoordinator = extractCoordinator
    }

}
