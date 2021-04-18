//
//  MainCoordinator.swift
//  DesafioIOS
//
//

import Foundation
import UIKit

class MainCoordinator : NSObject, Coordinator{
    
    
    let rootViewController : UINavigationController
    
    init(rootViewController : UINavigationController){
        self.rootViewController = rootViewController
        super.init()
        self.rootViewController.delegate = self
        
    }
    
    func start() {
        let myStatetementViewController = MyStatementViewController(viewModel: MyStatementViewModel(apiCaller: ApiCaller.shared))
        myStatetementViewController.coordinator = self
        rootViewController.pushViewController(myStatetementViewController, animated: true)
    }
    
    func showStatementDetail(id : String){
        let statementDetailViewModel = MyStatementDetailViewModel(
            apiCaller: ApiCaller.shared, statementId: id)
        let statementViewController = MyStatementDetailViewController(viewModel: statementDetailViewModel)
        rootViewController.pushViewController(statementViewController, animated: true)
    }
    
    
}

extension MainCoordinator : UINavigationControllerDelegate{
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        navigationController.navigationBar.isHidden = navigationController.viewControllers.count <= 1
    }
    
}

