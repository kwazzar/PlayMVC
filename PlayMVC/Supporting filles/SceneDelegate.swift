//
//  SceneDelegate.swift
//  PlayMVC
//
//  Created by Quasar on 26.04.2024.
//
import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let navigationController = UINavigationController()
        let mainCoordinator = MainCoordinator(navigationController: navigationController)
        mainCoordinator.start()
        
        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = mainCoordinator.tabBarController
        window.makeKeyAndVisible()
        self.window = window
    }
}
