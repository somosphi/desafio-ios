//
//  StatementCoordinator.swift
//  Desafio_Somosphi
//
//  Created by Suh on 04/08/22.
//

import UIKit

class StatementCoordinator: Coordinator {
    var navigationController: UINavigationController
    private var viewController: StatementViewController?
    private var detailCoordinator: DetailCoordinator?

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    deinit {
        print("testeeeee")
    }

    func start() {
        let statementVC = makeStatementViewController()
        navigationController.pushViewController(statementVC, animated: true)
    }

    private func makeStatementViewController() -> StatementViewController {
        let model = StatementModel()
        let service = AmountService()
        let serviceStatement = StatementService()
        let storyboard = UIStoryboard(name: "StatementStoryboard", bundle: nil)
        guard let viewController = storyboard.instantiateViewController(
            withIdentifier: "StatementViewController"
        ) as? StatementViewController else {
            fatalError()
        }

        model.serviceStatement = serviceStatement
        model.service = service
        model.delegate = viewController
        viewController.model = model
        viewController.delegate = self

        return viewController
    }

}

extension StatementCoordinator: StatementViewControllerDelegate {
    func showDetailStatement(statementID: String) {
        let detailCoordinator = DetailCoordinator(statementID: statementID, navigationController: navigationController)
        detailCoordinator.start()
        self.detailCoordinator = detailCoordinator
    }

}
