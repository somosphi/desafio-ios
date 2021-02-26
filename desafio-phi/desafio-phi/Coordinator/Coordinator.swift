//
//  Coordinator.swift
//  desafio-phi
//
//  Created by Marcus Vinicius Vieira Badiale on 25/02/21.
//

import UIKit

final class Coordinator: NSObject {

    private let window: UIWindow
    private let navigationController: UINavigationController
    
    init(window: UIWindow, navigationController: UINavigationController = UINavigationController()) {
        self.window = window
        self.navigationController = navigationController
    }
    
    func start() {
        window.rootViewController =  navigationController
        window.makeKeyAndVisible()
        
        navigationController.delegate = self
        
        routeToStatement()
    }
}


extension Coordinator: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController,
                              willShow viewController: UIViewController, animated: Bool) {
        viewController.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain,
                                                                          target: nil, action: nil)
    }
}

extension Coordinator {
    
    func routeToStatement() {
        let viewModel = StatementViewModel(coordinator: self)
        let viewController = StatementViewController(viewModel: viewModel)
        
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func routeToStatementDetail(statementId: String) {
        let viewModel = StatementDetailViewModel(coordinator: self, statementId: statementId)
        let viewController = StatementDetailViewController(viewModel: viewModel)
        
        navigationController.pushViewController(viewController, animated: true)
    }
}
