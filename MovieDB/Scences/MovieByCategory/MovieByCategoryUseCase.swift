//
//  MovieByCategoryUseCase.swift
//  MovieDB
//
//  Created by Bùi Xuân Huy on 11/28/19.
//  Copyright © 2019 huy. All rights reserved.
//

protocol MovieByCategoryUseCaseType {
    func getMovieList(genreId: Int) -> Observable<PagingInfo<MovieShortenDetail>>
    func getMoreMovieList(genreId: Int, page: Int) -> Observable<PagingInfo<MovieShortenDetail>>
}

struct MovieByCategoryUseCase: MovieByCategoryUseCaseType {
    func getMovieList(genreId: Int) -> Observable<PagingInfo<MovieShortenDetail>> {
        return getMoreMovieList(genreId: genreId, page: 1)
    }
    
    func getMoreMovieList(genreId: Int, page: Int) -> Observable<PagingInfo<MovieShortenDetail>> {
        let repository = CategoriesRepository()
        return repository.getMovieByCategories(page: page, genreId: genreId)
    }
}
