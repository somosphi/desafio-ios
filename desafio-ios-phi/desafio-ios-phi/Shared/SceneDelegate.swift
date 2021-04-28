//
//  SceneDelegate.swift
//  desafio-ios-phi
//
//  Created by Lidiane Gomes on 27/04/21.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = scene as? UIWindowScene else {
            return
        }
    
        let window = UIWindow(windowScene: scene)
        self.window = window
        let applicationCoordinator = ApplicationCoordinator(window: window)
        applicationCoordinator.start()
    }

}
