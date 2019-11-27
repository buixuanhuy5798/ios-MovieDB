//
//  MovieDetailRepository.swift
//  MovieDB
//
//  Created by Bùi Xuân Huy on 11/25/19.
//  Copyright © 2019 huy. All rights reserved.
//

protocol MovieDetailRepositoryType {
    func getMovieDetail(idMovie: Int) -> Observable<MovieDetail>
    func getActors(idMovie: Int) -> Observable<[Actor]>
}

struct MovieDetailRepository: MovieDetailRepositoryType {
    func getMovieDetail(idMovie: Int) -> Observable<MovieDetail> {
        let input = API.GetMovieDetailInput(idMovie: idMovie)
        return API.shared.getMovieDetail(input)
    }
    
    func getActors(idMovie: Int) -> Observable<[Actor]> {
        let input = API.GetActorOfMovieInput(idMovie: idMovie)
        return API.shared.getActorOfMovie(input)
            .map { output in
                guard let actors = output.actors else {
                    throw APIInvalidResponseError()
                }
                return actors
            }
    }
       
}
