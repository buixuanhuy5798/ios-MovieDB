//
//  SearchMovieUseCase.swift
//  MovieDB
//
//  Created by Bùi Xuân Huy on 11/27/19.
//  Copyright © 2019 huy. All rights reserved.
//

protocol SearchMovieUseCaseType {
    func getSearchResult(param: String) -> Observable<PagingInfo<MovieDetail>>
    func getMoreSearchResults(param: String, page: Int) -> Observable<PagingInfo<MovieDetail>>
}

struct SearchMovieUseCase: SearchMovieUseCaseType {
    func getMoreSearchResults(param: String, page: Int) -> Observable<PagingInfo<MovieDetail>> {
        let repository = SearchRepository()
        return repository.getSearch(query: param, page: page)
    }
    
    func getSearchResult(param: String) -> Observable<PagingInfo<MovieDetail>> {
        return getMoreSearchResults(param: param, page: 1)
    }
}
