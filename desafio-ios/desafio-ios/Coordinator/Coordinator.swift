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
    }
}

extension Coordinator {
    
    // MARK: - Internal methods
    
    func routeToStatement() {
        let viewModel = StatementViewModel(coordinator: self)
        let viewController = StatementViewController(viewModel: viewModel)
        
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func routeToDetail() {
        let viewModel = DetailViewModel(coordinator: self)
        let viewController = DetailViewController(viewModel: viewModel)
        
        navigationController.pushViewController(viewController, animated: true)
    }
}
