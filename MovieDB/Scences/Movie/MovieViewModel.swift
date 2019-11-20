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
    }
    
    struct Output {
        let topRated: Driver<[DataMovieSection]>
        let nowPlaying: Driver<[DataMovieSection]>
        let error: Driver<Error>
        let indicator: Driver<Bool>
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
 
        return Output(
            topRated: topRatedList,
            nowPlaying: nowPlayingList,
            error: error.asDriver(),
            indicator: indicator.asDriver()
        )
    }
    
}

