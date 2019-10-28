//
//  AppNavigator.swift
//  MovieDB
//
//  Created by Bùi Xuân Huy on 10/24/19.
//  Copyright © 2019 huy. All rights reserved.
//

protocol AppNavigatorType {
    func toMainTabBar()
    func toStartedScreen()
}

struct AppNavigator: AppNavigatorType {
    unowned let window: UIWindow
    
    func toMainTabBar() {
        let navigationController = UINavigationController()
        let mainTabBarNavigator = MainTabBarNavigator(naviagation: navigationController)
        mainTabBarNavigator.toMainTabBar()
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
    
    func toStartedScreen() {
        let startedController = StartedController.instantiate()
        let navigationController = UINavigationController(rootViewController: startedController)
        let startedNavigator = StartedNavigator(navigation: navigationController)
        let startedViewModel = StartedViewModel(navigator: startedNavigator)
        startedController.bindViewModel(to: startedViewModel)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
    
}
