//
//  DetailsRouter.swift
//  PhiChallenge
//
//  Created by Felipe Wilke on 13/11/20.
//

import Foundation

import UIKit

final class DetailsRouter {
    //MARK: - Properties
    
    private weak var context: UIViewController?
    private let id: String
    
    //MARK: - Object Lifecycle
    
    init(context: UIViewController, id: String) {
        self.context = context
        self.id = id
    }
    
    //MARK: - Public Methods
    
    func makeViewController() -> UIViewController {
        
        let api = APIRequest()
        let service = DetailsService(api: api)
        let presenter = DetailsPresenter(id: id, service: service)
        let viewController = DetailsViewController(presenter: presenter)
        
        context = viewController
        
        return viewController
    }
}
