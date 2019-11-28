//
//  CategoriesNavigator.swift
//  MovieDB
//
//  Created by Bùi Xuân Huy on 11/22/19.
//  Copyright © 2019 huy. All rights reserved.
//

protocol CategoriesNavigatorType {
    func toMoreMovie(catgory: Category)
}

struct CategoriesNavigator: CategoriesNavigatorType {
    unowned let navigation: UINavigationController
    
    func toMoreMovie(catgory: Category) {
        let viewController = MovieByCategoryController.instantiate()
        let navigator = MovieByCategoryNavigator(navigation: navigation)
        let useCase = MovieByCategoryUseCase()
        let viewModel = MovieByCatgoryViewModel(navigator: navigator,
                                           useCase: useCase,
                                           category: catgory)
        viewController.bindViewModel(to: viewModel)
        navigation.pushViewController(viewController, animated: true)
    }
}
