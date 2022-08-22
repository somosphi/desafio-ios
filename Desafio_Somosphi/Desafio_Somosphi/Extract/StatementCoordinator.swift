//
//  StatementCoordinator.swift
//  Desafio_Somosphi
//
//  Created by Suh on 04/08/22.
//

import UIKit

class StatementCoordinator: Coordinator {
    var navigationController: UINavigationController
    // var viewController: StatementViewController

    init(navigationController: UINavigationController) { // viewController: StatementViewController) {
        self.navigationController = navigationController
        // self.viewController = viewController
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
        viewController.coordinator = self

        return viewController
    }

}
