//
//  MovieUseCase.swift
//  MovieDB
//
//  Created by Bùi Xuân Huy on 11/11/19.
//  Copyright © 2019 huy. All rights reserved.
//

protocol MovieUseCaseType {
    func loadMoreRatedMovie(page: Int) -> Observable<PagingInfo<TopRated>>
    func getTopRatedMovie() -> Observable<PagingInfo<TopRated>>
}

struct MovieUseCase: MovieUseCaseType {

    func getTopRatedMovie() -> Observable<PagingInfo<TopRated>> {
        return loadMoreRatedMovie(page: 1)
    }

    func loadMoreRatedMovie(page: Int) -> Observable<PagingInfo<TopRated>> {
        return MovieRepository.shared.getTopRatedMovie(page: page)
    }

}
