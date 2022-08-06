//
//  SceneDelegate.swift
//  Desafio_Somosphi
//
//  Created by Suh on 02/08/22.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var coordinator: AppCoordinator?
    var window: UIWindow?

    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowscene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowscene)
        let navigationController = UINavigationController()
        coordinator = AppCoordinator(navigationController: navigationController, window: window)
        coordinator?.start()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }

}
