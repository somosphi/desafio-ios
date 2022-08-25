//
//  DetailCoordinator.swift
//  Desafio_Somosphi
//
//  Created by Suh on 25/08/22.
//

import Foundation
import UIKit

class DetailCoordinator: Coordinator {
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let detailViewController = makeDetailViewController()
        navigationController.pushViewController(detailViewController, animated: true)
    }

    private func makeDetailViewController() -> DetailViewController {
        let storyboard = UIStoryboard.init(name: "DetailStoryboard", bundle: nil)
        guard let viewController = storyboard.instantiateViewController(
            withIdentifier: "DetailViewController") as? DetailViewController else {
            fatalError()
        }

        return viewController
    }

}
