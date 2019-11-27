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
    func loadMorePopular(page: Int) -> Observable<PagingInfo<Popular>>
    func getPopular() -> Observable<PagingInfo<Popular>>
    func mapNowplayingItem(_ nowPlaying: [NowPlaying], _ numberOfItems: Int) -> [DataMovieSection]
    func mapTopRatedItem(_ topRated: [TopRated], _ numberOfItems: Int) -> [DataMovieSection]
    func mapPopularItem(_ popular: [Popular], _ numberOfItems: Int) -> [DataMovieSection]
}

struct MovieUseCase: MovieUseCaseType {
    
    let repository = MovieRepository.shared

    func getTopRatedMovie() -> Observable<PagingInfo<TopRated>> {
        return loadMoreRatedMovie(page: 1)
    }

    func loadMoreRatedMovie(page: Int) -> Observable<PagingInfo<TopRated>> {
        return repository.getTopRatedMovie(page: page)
    }
    
    func getNowPlaying() -> Observable<PagingInfo<NowPlaying>> {
        return loadMoreNowPlaying(page: 1)
    }
    
    func loadMoreNowPlaying(page: Int) -> Observable<PagingInfo<NowPlaying>> {
        return repository.getNowPlaying(page: page)
    }
    
    func getPopular() -> Observable<PagingInfo<Popular>> {
           return repository.getPopular(page: 1)
    }
       
       func loadMorePopular(page: Int) -> Observable<PagingInfo<Popular>> {
           return repository.getPopular(page: page)
    }
    
    func mapNowplayingItem(_ nowPlaying: [NowPlaying], _ numberOfItems: Int) -> [DataMovieSection] {
        var items = nowPlaying.prefix(numberOfItems)
            .map {
                DataMovie.nowPlaying(nowPlaying: $0)
            }
        items.append(DataMovie.more)
        return [DataMovieSection(model: "", items: items)]
    }
    
    func mapTopRatedItem(_ topRated: [TopRated], _ numberOfItems: Int) -> [DataMovieSection] {
        var items = topRated.prefix(numberOfItems)
            .map {
                DataMovie.topRated(topRated: $0)
            }
        items.append(DataMovie.more)
        return [DataMovieSection(model: "", items: items)]
    }
    
    func mapPopularItem(_ popular: [Popular], _ numberOfItems: Int) -> [DataMovieSection] {
        var items = popular.prefix(numberOfItems)
        .map {
            DataMovie.popular(popular: $0)
        }
        items.append(DataMovie.more)
        return [DataMovieSection(model: "", items: items)]
    }
    
}
