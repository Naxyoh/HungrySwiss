//
//  RootCoordinator.swift
//  HungrySwiss
//
//  Created by Yoan Smit on 17/08/2023.
//

import UIKit

protocol CityListCoordinator {
    func navigateToCityRestaurants(city: CityDTO, allCities: [CityDTO])
}

struct RootCoordinator {
    
    struct Dependencies {
        private static let httpProvider: HTTPProvider = URLSessionHTTPProvider(
            baseURL: "https://dev-9r45b2epb810w4g.api.raw-labs.com",
            urlSession: URLSession(configuration: .ephemeral)
        )
        
        private static let cityListRepository: CityListRepositoryProtocol = CityListRepository(httpProvider: httpProvider)
        private static let cityDetailsRepository: CityDetailsRepositoryProtocol = CityDetailsRepository(httpProvider: httpProvider)
        
        static let fetchCitiesUseCase: FetchCitiesUseCaseProtocol = FetchCitiesUseCase(citiesRepository: cityListRepository)
        static let fetchCityRestaurantsUseCase: FetchCityRestaurantsUseCaseProtocol = FetchCityRestaurantsUseCase(citiesRepository: cityDetailsRepository)
    }
    
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
        let cityListViewModel = CityListViewModel(
            fetchCitiesUseCase: Dependencies.fetchCitiesUseCase,
            cityListCoordinator: self
        )
        let cityListViewController = CityListViewController(viewModel: cityListViewModel)
        let controller = UINavigationController(rootViewController: cityListViewController)
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        
        let buttonAppearance = UIBarButtonItemAppearance(style: .plain)
        buttonAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.red1]

        // Apply button appearance
        appearance.buttonAppearance = buttonAppearance

        // Apply tint to the back arrow "chevron"
        UINavigationBar.appearance().tintColor = .red1
        
        controller.navigationBar.standardAppearance = appearance
        controller.navigationBar.scrollEdgeAppearance = appearance
        
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

extension RootCoordinator: CityListCoordinator {
    func navigateToCityRestaurants(city: CityDTO, allCities: [CityDTO]) {
        let viewModel = CityDetailsViewModel(
            city: city,
            availableCities: allCities,
            fetchCityRestaurantsUseCase: Dependencies.fetchCityRestaurantsUseCase
        )
        let controller = CityDetailsViewController(viewModel: viewModel)
        
        let cityNavigationController = (window.rootViewController as? UITabBarController)?.viewControllers?[0] as? UINavigationController
        
        cityNavigationController?.pushViewController(controller, animated: true)
    }
}
