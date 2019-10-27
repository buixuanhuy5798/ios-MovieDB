//
//  StartedNavgator.swift
//  MovieDB
//
//  Created by Bùi Xuân Huy on 10/25/19.
//  Copyright © 2019 huy. All rights reserved.
//

protocol StartedNavigatorType {
    func toMainTabBar()
}

struct StartedNavigator: StartedNavigatorType {
    unowned let navigation: UINavigationController
    
    func toMainTabBar() {
        let mainTabBarNavigator = MainTabBarNavigator(naviagation: navigation)
        mainTabBarNavigator.toMainTabBar()
    }
}

