//
//  MovieNavigator.swift
//  MovieDB
//
//  Created by Bùi Xuân Huy on 11/11/19.
//  Copyright © 2019 huy. All rights reserved.
//

protocol MovieNavigatorType {
    func toNextScreen(dataMovie: DataMovie)
    func toSearch()
}

struct MovieNavigator: MovieNavigatorType {
    unowned let navigation: UINavigationController
    
    func toNextScreen(dataMovie: DataMovie) {
        switch dataMovie {
        case .more:
            toMoreMovie(dataMovie: dataMovie)
        case .nowPlaying(let nowPlaying):
            toMovieDetailScreen(movieId: nowPlaying.id)
        case .topRated(let topRated):
            toMovieDetailScreen(movieId: topRated.id)
        case .popular(let popular):
            toMovieDetailScreen(movieId: popular.id)
        }
    }
    
    func toMoreMovie(dataMovie: DataMovie) {
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
    
    func toSearch() {
        let controller = SearchMovieController.instantiate()
        let useCase = SearchMovieUseCase()
        let navigator = SeachMovieNavigator(navigation: navigation)
        let viewModel = SearchMovieViewModel(navigator: navigator, useCase: useCase)
        controller.bindViewModel(to: viewModel)
        navigation.pushViewController(controller, animated: true)
    }
}
