//
//  MainCoordinator + TabBar.swift
//  PlayMVC
//
//  Created by Quasar on 28.04.2024.
//
import Foundation
import UIKit

protocol AnyCoordinator {
    var navigationController: UINavigationController { get set }
}

protocol Coordinator: AnyCoordinator {
    associatedtype Controller: UIViewController
    var childCoordinators: [AnyCoordinator] { get set }
    var tabBarController: Controller { get set }
    
    func start()
}

class MainCoordinator: Coordinator {
    var childCoordinators: [AnyCoordinator] = []
    var navigationController: UINavigationController
    var tabBarController: UITabBarController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.tabBarController = UITabBarController()
    }
    
    func start() {
        let firstViewController = HomeVC()
        firstViewController.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "home1") , tag: 0)
        
        let secondViewController = IpInfoVC()
        secondViewController.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "map1"), tag: 1)
        
        let thirdViewController = ShareVC()
        thirdViewController.tabBarItem = UITabBarItem(title: "", image: UIImage(named:  "share1"), tag: 2)
        
        tabBarController.viewControllers = [firstViewController, secondViewController, thirdViewController]
        tabBarController.tabBar.tintColor = UIColor.red
    }
}

