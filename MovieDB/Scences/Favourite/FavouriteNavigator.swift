//
//  FavouriteNavigator.swift
//  MovieDB
//
//  Created by Bùi Xuân Huy on 11/28/19.
//  Copyright © 2019 huy. All rights reserved.
//

protocol FavouriteNavigatorType {
    func back()
    func toMovieDetailScreen(movieId: Int)
}

struct FavouriteNavigator: FavouriteNavigatorType {
    unowned let navigation: UINavigationController
    
    func back() {
        navigation.popViewController(animated: true)
    }
    
    func toMovieDetailScreen(movieId: Int) {
        let controller = MovieDetailController.instantiate()
        let useCase = MovieDetailUseCase(movieId: movieId)
        let navigator = MovieDetailNavigator(navigation: navigation)
        let viewModel = MovieDetailViewModel(navigator: navigator,
                                             useCase: useCase)
        controller.bindViewModel(to: viewModel)
        navigation.pushViewController(controller, animated: true)
    }
}

