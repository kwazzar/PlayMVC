//
//  MainCoordinator.swift
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
    var rootViewController: Controller { get set }

    func start()
}


class MainCoordinator: Coordinator {
    var childCoordinators: [AnyCoordinator] = []
    var navigationController: UINavigationController
    var rootViewController: UITabBarController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.rootViewController = UITabBarController()
    }

    
    func start() {
        let firstViewController = MainVC()
        firstViewController.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "home1") , tag: 0)

        let secondViewController = SecondVC()
        secondViewController.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "map1"), tag: 1)

        let thirdViewController = ThirdVC()
        thirdViewController.tabBarItem = UITabBarItem(title: "", image: UIImage(named:  "share1"), tag: 2)

        rootViewController.viewControllers = [firstViewController, secondViewController, thirdViewController]
        navigationController.pushViewController(rootViewController, animated: false)

        rootViewController.tabBar.tintColor = UIColor.red
    }
}

