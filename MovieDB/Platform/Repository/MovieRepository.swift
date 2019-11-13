//
//  MovieRepository.swift
//  MovieDB
//
//  Created by Bùi Xuân Huy on 11/11/19.
//  Copyright © 2019 huy. All rights reserved.
//

protocol MovieRepositoryType {
    func getTopRatedMovie(page: Int) -> Observable<PagingInfo<TopRated>>
}

final class MovieRepository: MovieRepositoryType {
    
    static let shared = MovieRepository()
    
    func getTopRatedMovie(page: Int) -> Observable<PagingInfo<TopRated>> {
        let input = API.GetTopRatedMovieInput(page: page)
        return API.shared.getTopRatedMovie(input)
            .map { output in
                guard let topRated = output.topRatedMovies else {
                    throw APIInvalidResponseError()
                }
                return PagingInfo<TopRated>(page: page, items: topRated)
            }
    }
}

