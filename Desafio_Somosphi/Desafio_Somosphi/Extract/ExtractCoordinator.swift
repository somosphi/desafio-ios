//
//  ExtractCoordinator.swift
//  Desafio_Somosphi
//
//  Created by Suh on 04/08/22.
//

import UIKit

class ExtractCoordinator: Coordinator {
    var navigationController: UINavigationController
    // var viewController: ExtractViewController

    init(navigationController: UINavigationController) { // viewController: ExtractViewController) {
        self.navigationController = navigationController
        // self.viewController = viewController
    }

    deinit {
        print("testeeeee")
    }

    func start() {
        let extractVC = ExtractViewController()
        extractVC.coordinator = self
        navigationController.pushViewController(extractVC, animated: true)
    }

}
