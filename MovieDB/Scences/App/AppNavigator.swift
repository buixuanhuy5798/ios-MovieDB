//
//  AppNavigator.swift
//  MovieDB
//
//  Created by Bùi Xuân Huy on 10/24/19.
//  Copyright © 2019 huy. All rights reserved.
//

protocol AppNavigatorType {
    func toMain()
}

struct AppNavigator: AppNavigatorType {
    unowned let window: UIWindow
    
    func toMain() {
        let mainTabBarController = MainTabBarController.instantiate()
        let navigationController = UINavigationController(rootViewController: mainTabBarController)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
}
