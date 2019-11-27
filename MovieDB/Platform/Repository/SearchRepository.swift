//
//  SearchRepository.swift
//  MovieDB
//
//  Created by Bùi Xuân Huy on 11/27/19.
//  Copyright © 2019 huy. All rights reserved.
//

protocol SearchRepositoryType {
    func getSearch(query: String, page: Int) -> Observable<PagingInfo<MovieDetail>>
}

struct SearchRepository: SearchRepositoryType {
    func getSearch(query: String, page: Int) -> Observable<PagingInfo<MovieDetail>> {
        let input = API.APISearchInput(query: query, page: page)
        return API.shared.getSearchResult(input)
            .map { output in
                guard let movieDatails = output.movieDetail else {
                    throw APIInvalidResponseError()
                }
                return PagingInfo<MovieDetail>(page: page, items: movieDatails)
            }
    }
}
