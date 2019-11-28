//
//  MoreMovieRepository.swift
//  MovieDB
//
//  Created by Bùi Xuân Huy on 11/28/19.
//  Copyright © 2019 huy. All rights reserved.
//

protocol MoreMovieRepositoryType {
    func getMovieList(type: MovieType, page: Int) -> Observable<PagingInfo<MovieShortenDetail>>
}

struct MoreMovieRepository: MoreMovieRepositoryType {
    func getMovieList(type: MovieType, page: Int) -> Observable<PagingInfo<MovieShortenDetail>> {
        let input = API.GetMoreMovieInput(type: type, page: page)
        return API.shared.getMoreMovie(input)
            .map { output in
                guard let movieList = output.moviesList else {
                    throw APIInvalidResponseError()
                }
                return PagingInfo<MovieShortenDetail>(page: page, items: movieList)
            }
    }
}
