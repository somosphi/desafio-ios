//
//  Coordinator.swift
//  desafio-ios
//
//  Created by Gustavo Igor Gonçalves Travassos on 12/01/21.
//

import UIKit

// MARK: - Class

final class Coordinator {
    
    // MARK: - Private variables
    
    private let window: UIWindow
    private let navigationController: UINavigationController
    
    // MARK: - Initializers
    
    init(window: UIWindow, navigationController: UINavigationController = UINavigationController()) {
        self.window = window
        self.navigationController = navigationController
        
        self.navigationController.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController.navigationBar.shadowImage = UIImage()
        let color = UIColor.phiBlack
        navigationController.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: color as Any]
        navigationController.navigationBar.titleTextAttributes =  [NSAttributedString.Key.foregroundColor: color as Any]
        navigationController.navigationBar.tintColor = color
    }
    
    // MARK: - Public methods
    
    func start() {
        window.rootViewController =  navigationController
        window.makeKeyAndVisible()
        
        routeToStatement()
//        routeToDetail(id: "49E27207-F3A7-4264-B021-0188690F7D43")
    }
}

extension Coordinator {
    
    // MARK: - Internal methods
    
    func routeToStatement() {
        let viewModel = StatementViewModel(coordinator: self)
        let viewController = StatementViewController(viewModel: viewModel)
        
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func routeToDetail(id: String) {
        let viewModel = DetailViewModel(coordinator: self, id: id)
        let viewController = DetailViewController(viewModel: viewModel)
        
        navigationController.pushViewController(viewController, animated: true)
    }
}
