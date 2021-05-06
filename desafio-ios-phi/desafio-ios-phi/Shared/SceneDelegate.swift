//
//  SceneDelegate.swift
//  desafio-ios-phi
//
//  Created by Lidiane Gomes on 27/04/21.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    var coordinator: ApplicationCoordinator?
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let scene = scene as? UIWindowScene else {
            return
        }
        
        let navigationController = UINavigationController()
        coordinator = ApplicationCoordinator(navigationController: navigationController)
        coordinator?.start()
        
        window = UIWindow(windowScene: scene)
        window?.rootViewController = navigationController
        window?.overrideUserInterfaceStyle = .light
        window?.makeKeyAndVisible()
    }
    
}
