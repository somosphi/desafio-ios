//
//  ApplicationCoordinator.swift
//  desafio-ios-phi
//
//  Created by Lidiane Gomes on 27/04/21.
//

import Foundation
import UIKit

class ApplicationCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
        navigationController = UINavigationController()
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
    
    func start() {
        let childCoordinator = StatementCoordinator(navigationController: navigationController)
        childCoordinators.append(childCoordinator)
        childCoordinator.start()
    }
}
