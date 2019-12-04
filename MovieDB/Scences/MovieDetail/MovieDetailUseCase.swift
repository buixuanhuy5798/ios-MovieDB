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
    func addOrRemoveFavouriteMovie(movie: MovieDetail)
    func checkMovieExistOnDatabase() -> Observable<Bool>
}

struct MovieDetailUseCase: MovieDetailUseCaseType {
   
    let movieId: Int
    let movieDetailRepository = MovieDetailRepository()
    let favouriteRepositopy = FavouriteRepository()
    
    func getMovieDetail() -> Observable<MovieDetail> {
        return movieDetailRepository.getMovieDetail(idMovie: movieId)
    }
    
    func getActorsOfMove() -> Observable<[Actor]> {
        return movieDetailRepository.getActors(idMovie: movieId)
    }
    
    func addOrRemoveFavouriteMovie(movie: MovieDetail)  {
        let movieShortenDetail = MapperMovie.shared.movieDetailToShortenType(movieDetail: movie)
        favouriteRepositopy.addOrRemoveMovie(movie: movieShortenDetail)
    }
    
    func checkMovieExistOnDatabase() -> Observable<Bool> {
        return favouriteRepositopy.existOnDatabase(movieId: movieId)
    }
       
}
