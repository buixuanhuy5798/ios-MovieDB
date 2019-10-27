//
//  MainNavigator.swift
//  MovieDB
//
//  Created by Bùi Xuân Huy on 10/27/19.
//  Copyright © 2019 huy. All rights reserved.
//

protocol MainTabBarNavigatorType {
    func toMainTabBar()
}

struct MainTabBarNavigator: MainTabBarNavigatorType {
    unowned let naviagation: UINavigationController
    
    func toMainTabBar() {
        let mainTabBarController = MainTabBarController.instantiate()
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
        naviagation.pushViewController(mainTabBarController, animated: true)
    }
}
