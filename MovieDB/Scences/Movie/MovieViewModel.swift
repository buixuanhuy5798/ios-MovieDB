//
//  MovieViewModel.swift
//  MovieDB
//
//  Created by Bùi Xuân Huy on 11/11/19.
//  Copyright © 2019 huy. All rights reserved.
//

typealias DataMovieSection = SectionModel<String, DataMovie>

enum DataMovie {
    case topRated(topRated: TopRated)
    case nowPlaying(nowPlaying: NowPlaying)
    case popular(popular: Popular)
    case more
}

struct MovieViewModel {
    let navigator: MovieNavigatorType
    let useCase: MovieUseCaseType
}

extension MovieViewModel: ViewModelType {
    struct Constants {
        static let defaultNumberOfMovie = 7
    }

    struct Input {
        let loadTrigger: Driver<Void>
        let selectTopRatedTrigger: Driver<IndexPath>
        let selectNowPlayingTrigger: Driver<IndexPath>
        let selectPopularTrigger: Driver<IndexPath>
    }
    
    struct Output {
        let topRated: Driver<[DataMovieSection]>
        let nowPlaying: Driver<[DataMovieSection]>
        let popular: Driver<[DataMovieSection]>
        let error: Driver<Error>
        let indicator: Driver<Bool>
        let topRatedSelected: Driver<Void>
        let nowPlayingSelected: Driver<Void>
        let popularSelected: Driver<Void>
    }
    
    func transform(_ input: Input) -> Output {
        let indicator = ActivityIndicator()
        let error = ErrorTracker()
        let topRatedList = input.loadTrigger
           .flatMapLatest { _ in
               return self.useCase.getTopRatedMovie()
                    .trackError(error)
                    .trackActivity(indicator)
                    .asDriverOnErrorJustComplete()
            }
            .map {
                self.useCase.mapTopRatedItem($0.items, Constants.defaultNumberOfMovie)
            }
        
        
        let nowPlayingList = input.loadTrigger
            .flatMapLatest { _ in
                return self.useCase.getNowPlaying()
                    .trackError(error)
                    .trackActivity(indicator)
                    .asDriverOnErrorJustComplete()
            }
            .map {
                self.useCase.mapNowplayingItem($0.items,
                                               Constants.defaultNumberOfMovie)
            }
        
        let popularList = input.loadTrigger
            .flatMapLatest { _ in
                self.useCase.getPopular()
                .trackError(error)
                .trackActivity(indicator)
                .asDriverOnErrorJustComplete()
            }
            .map {
                self.useCase.mapPopularItem($0.items,
                                            Constants.defaultNumberOfMovie)
            }
        
        let topRatedSelected = input.selectTopRatedTrigger
            .withLatestFrom(topRatedList) { indexPath, topRatedList in
                return topRatedList.first?.items[indexPath.row]
            }
            .do(onNext: {
                self.navigator.toNextScreen(dataMovie: $0 ?? .topRated(topRated: TopRated()))
            })
            .mapToVoid()

        let nowPlayingSelected = input.selectNowPlayingTrigger
            .withLatestFrom(nowPlayingList) { indexPath, nowPlayingList in
                return nowPlayingList.first?.items[indexPath.row]
            }.do(onNext: {
                self.navigator.toNextScreen(dataMovie: $0 ?? .nowPlaying(nowPlaying: NowPlaying()))
            })
            .mapToVoid()
        
        let popularSelected = input.selectPopularTrigger
             .withLatestFrom(popularList) { indexPath, popularList in
                return popularList.first?.items[indexPath.row]
             }.do(onNext: {
                self.navigator.toNextScreen(dataMovie: $0 ?? .popular(popular: Popular()))
             })
             .mapToVoid()
 
        return Output(
            topRated: topRatedList,
            nowPlaying: nowPlayingList,
            popular: popularList,
            error: error.asDriver(),
            indicator: indicator.asDriver(),
            topRatedSelected: topRatedSelected,
            nowPlayingSelected: nowPlayingSelected,
            popularSelected: popularSelected
        )
    }
    
}

