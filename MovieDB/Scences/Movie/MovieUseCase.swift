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
    func loadMoreNowPlaying(page: Int) -> Observable<PagingInfo<NowPlaying>>
    func getNowPlaying() -> Observable<PagingInfo<NowPlaying>>
}

struct MovieUseCase: MovieUseCaseType {

    func getTopRatedMovie() -> Observable<PagingInfo<TopRated>> {
        return loadMoreRatedMovie(page: 1)
    }

    func loadMoreRatedMovie(page: Int) -> Observable<PagingInfo<TopRated>> {
        return MovieRepository.shared.getTopRatedMovie(page: page)
    }
    
    func getNowPlaying() -> Observable<PagingInfo<NowPlaying>> {
        return loadMoreNowPlaying(page: 1)
    }
    
    func loadMoreNowPlaying(page: Int) -> Observable<PagingInfo<NowPlaying>> {
        return MovieRepository.shared.getNowPlaying(page: page)
    }
}
