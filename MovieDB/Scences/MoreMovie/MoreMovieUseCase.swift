//
//  MoreMovieUseCase.swift
//  MovieDB
//
//  Created by Bùi Xuân Huy on 11/28/19.
//  Copyright © 2019 huy. All rights reserved.
//

protocol MoreMovieUseCaseType {
    func getMovieList(type: MovieType) -> Observable<PagingInfo<MovieShortenDetail>>
    func getMoreMovieList(type: MovieType, page: Int) -> Observable<PagingInfo<MovieShortenDetail>>
}

struct MoreMovieUseCase: MoreMovieUseCaseType {
    func getMovieList(type: MovieType) -> Observable<PagingInfo<MovieShortenDetail>> {
        getMoreMovieList(type: type, page: 1)
    }
    
    func getMoreMovieList(type: MovieType, page: Int) -> Observable<PagingInfo<MovieShortenDetail>> {
        let repository = MoreMovieRepository()
        return repository.getMovieList(type: type, page: page)
    }
    
}
