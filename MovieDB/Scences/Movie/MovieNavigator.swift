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
        default:
            toMovieDetail(dataMovie: dataMovie)
        }
    }
    
    func toMoreMovie(dataMovie: DataMovie) {
    }
    
    func toMovieDetail(dataMovie: DataMovie) {
    }
}
