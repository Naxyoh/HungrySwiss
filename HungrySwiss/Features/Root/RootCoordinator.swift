//
//  RootCoordinator.swift
//  HungrySwiss
//
//  Created by Yoan Smit on 17/08/2023.
//

import UIKit

struct RootCoordinator {
    
    private let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        let tabBarController = UITabBarController()
        
        tabBarController.viewControllers = [
            makeCityListViewController(),
            makeOrdersViewController(),
            makeAccountViewController(),
        ]
        stylizeTabBar(tabBarController.tabBar)
        
        window.rootViewController = tabBarController
        window.makeKeyAndVisible()
    }
    
    private func stylizeTabBar(_ tabBar: UITabBar) {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .gray2
        
        setTabBarItemColors(appearance.stackedLayoutAppearance)
        setTabBarItemColors(appearance.compactInlineLayoutAppearance)
        
        tabBar.standardAppearance = appearance
        tabBar.scrollEdgeAppearance = tabBar.standardAppearance
    }
    
    private func setTabBarItemColors(_ itemAppearance: UITabBarItemAppearance) {
        itemAppearance.normal.iconColor = .gray1
        itemAppearance.normal.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.gray1]
        
        itemAppearance.selected.iconColor = .red1
        itemAppearance.selected.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.red1]
    }
    
    private func makeCityListViewController() -> UIViewController {
        let controller = UINavigationController(rootViewController: CityListViewController())
        controller.tabBarItem = UITabBarItem(
            title: "DeinDeal",
            image: UIImage(named: "tab-cities"),
            tag: 0
        )
        
        return controller
    }
    
    private func makeOrdersViewController() -> UIViewController {
        let controller = OrdersViewController()
        controller.tabBarItem = UITabBarItem(
            title: "Orders",
            image: UIImage(named: "tab-orders"),
            tag: 1
        )
        
        return controller
    }
    
    private func makeAccountViewController() -> UIViewController {
        let controller = AccountViewController()
        controller.tabBarItem = UITabBarItem(
            title: "Account",
            image: UIImage(named: "tab-account"),
            tag: 2
        )
        
        return controller
    }
    
}
