//
//  MoreMovieDetailUseCase.swift
//  MovieDB
//
//  Created by Bùi Xuân Huy on 11/25/19.
//  Copyright © 2019 huy. All rights reserved.
//

protocol MovieDetailUseCaseType {
    func getMovieDetail() -> Observable<MovieDetail>
    func getActorsOfMove() -> Observable<[Actor]>
}

struct MovieDetailUseCase: MovieDetailUseCaseType {
    let movieId: Int
    let repository = MovieDetailRepository()
    
    func getMovieDetail() -> Observable<MovieDetail> {
        return repository.getMovieDetail(idMovie: movieId)
    }
    
    func getActorsOfMove() -> Observable<[Actor]> {
        return repository.getActors(idMovie: movieId)
    }
}
