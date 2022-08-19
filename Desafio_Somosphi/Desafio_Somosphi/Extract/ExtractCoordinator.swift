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
        let extractVC = makeExtractViewController()
        navigationController.pushViewController(extractVC, animated: true)
    }

    private func makeExtractViewController() -> ExtractViewController {
        let model = ExtractModel()
        let storyboard = UIStoryboard(name: "ExtractStoryboard", bundle: nil)
        guard let viewController = storyboard.instantiateViewController(
            withIdentifier: "ExtractViewController"
        ) as? ExtractViewController else {
            fatalError()
        }

        model.delegate = viewController
        viewController.model = model
        viewController.coordinator = self

        return viewController
    }

}
