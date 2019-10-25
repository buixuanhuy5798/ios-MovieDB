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
        let movieController = MovieController.instantiate().then {
            $0.tabBarItem = UITabBarItem(title: Constants.titleMovieTabBar,
                                         image: Constants.iconMovie,
                                         selectedImage: Constants.iconMovieSelected)
        }
        let categoriesController = CategoriesController.instantiate().then {
            $0.tabBarItem = UITabBarItem(title: Constants.titleCategoriesTabBar,
                                         image: Constants.iconCategories,
                                         selectedImage: Constants.iconCategoriesSelected)
        }
        let favouriteController = FavouriteController.instantiate().then {
            $0.tabBarItem = UITabBarItem(title: Constants.titleFavouriteTabBar,
                                         image: Constants.iconFavorite,
                                         selectedImage: Constants.iconFavouriteSelected)
        }
        mainTabBarController.do {
            $0.viewControllers = [movieController,
                                  categoriesController,
                                  favouriteController]
            $0.tabBar.barStyle = .black
            $0.tabBar.tintColor = UIColor.tinColorTabBar
        }
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
    
}
