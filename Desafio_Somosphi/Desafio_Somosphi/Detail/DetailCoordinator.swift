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
    var statementID: String

    init(statementID: String, navigationController: UINavigationController) {
        self.statementID = statementID
        self.navigationController = navigationController
    }

    func start() {
        let detailViewController = makeDetailViewController()
        navigationController.pushViewController(detailViewController, animated: true)
    }

    private func makeDetailViewController() -> DetailViewController {
        let model = DetailModel(statementID: statementID)
        let service = DetailService()
        let storyboard = UIStoryboard.init(name: "DetailStoryboard", bundle: nil)
        guard let viewController = storyboard.instantiateViewController(
            withIdentifier: "DetailViewController") as? DetailViewController else {
            fatalError()
        }

        model.service = service
        model.delegate = viewController
        viewController.model = model

        return viewController
    }

}
