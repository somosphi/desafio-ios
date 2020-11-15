//
//  MainRouter.swift
//  PhiChallenge
//
//  Created by Felipe Wilke on 10/11/20.
//

import UIKit

final class MainRouter {
    //MARK: - Properties
    
    private weak var context: UIViewController?
    
    //MARK: - Public Methods
    func makeViewController() -> UIViewController {
        
        let router = self
        let api = APIRequest()
        let balanceService = BalanceService(api: api)
        let statementSerivce = StatementService(api: api)
        
        let presenter = MainPresenter(router: router,
                                      balanceService: balanceService,
                                      statementService: statementSerivce)
        
        let viewController = MainViewController(presenter: presenter)
      
        context = viewController
        
        return viewController
    }
}
//MARK: - StatementRoutering Interface Implementation
extension MainRouter: StatementRoutering {
    
    func navigateToDetailsScene(id: String) {
        
        guard let context = context else { return }
        let router = DetailsRouter(context: context, id: id)
        
        context.navigationController?.pushViewController(router.makeViewController(), animated: true)
    }
}
