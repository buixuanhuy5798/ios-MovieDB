//
//  MovieRepository.swift
//  MovieDB
//
//  Created by Bùi Xuân Huy on 11/11/19.
//  Copyright © 2019 huy. All rights reserved.
//

protocol MovieRepositoryType {
    func getTopRatedMovie(page: Int) -> Observable<PagingInfo<TopRated>>
    func getNowPlaying(page: Int) -> Observable<PagingInfo<NowPlaying>>
    func getPopular(page: Int) -> Observable<PagingInfo<Popular>>
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
    
    func getNowPlaying(page: Int) -> Observable<PagingInfo<NowPlaying>> {
        let input = API.GetNowPlayingInput(page: page)
        return API.shared.getNowPlaying(input)
            .map { output in
                guard let nowPlaying = output.nowPlaying else {
                    throw APIInvalidResponseError()
                }
                return PagingInfo<NowPlaying>(page: page, items: nowPlaying)
            }
    }
    
    func getPopular(page: Int) -> Observable<PagingInfo<Popular>> {
        let input = API.GetPopularInput(page: page)
        return API.shared.getPopular(input)
            .map { output in
                guard let popular = output.popular else {
                    throw APIInvalidResponseError()
                }
                return PagingInfo<Popular>(page: page, items: popular)
            }
    }
}

