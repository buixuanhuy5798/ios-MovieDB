//
//  MovieNavigator.swift
//  MovieDB
//
//  Created by Bùi Xuân Huy on 11/11/19.
//  Copyright © 2019 huy. All rights reserved.
//

protocol MovieNavigatorType {
    func toNextScreen(dataMovie: DataMovie)
}

struct MovieNavigator: MovieNavigatorType {
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
    }
}
