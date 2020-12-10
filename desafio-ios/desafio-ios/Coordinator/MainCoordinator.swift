//
//  MainCoordinator.swift
//  desafio-ios
//
//  Created by Alexandre Scheer Bing on 07/12/20.
//

import Foundation
import UIKit

class MainCoordinator {
    
    private let window: UIWindow
    private let navigationController: UINavigationController
    
    init (window: UIWindow, navigationController: UINavigationController = UINavigationController()) {
        self.window = window
        self.navigationController = navigationController
        self.navigationController.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController.navigationBar.shadowImage = UIImage()
        let color = UIColor(named: "ElementsColor")
        navigationController.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: color as Any]
        navigationController.navigationBar.titleTextAttributes =  [NSAttributedString.Key.foregroundColor: color as Any]
        navigationController.navigationBar.tintColor = color
    }
    func start() {
        let viewController = StatementViewController.instantiate(with: StatementViewModel())
        viewController.coordinator = self
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func goToDetail(with id: String){
        print(id)
        let detailViewModel = DetailViewModel(id: id)
        let destinationViewController = DetailViewController.instantiate(with: detailViewModel)
        self.navigationController.pushViewController(destinationViewController, animated: true)
    }
}
