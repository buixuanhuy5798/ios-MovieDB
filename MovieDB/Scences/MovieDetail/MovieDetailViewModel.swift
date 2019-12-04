//
//  MovieDetailViewModel.swift
//  MovieDB
//
//  Created by Bùi Xuân Huy on 11/25/19.
//  Copyright © 2019 huy. All rights reserved.
//

struct MovieDetailViewModel {
    let navigator: MovieDetailNavigatorType
    let useCase: MovieDetailUseCaseType
}

extension MovieDetailViewModel: ViewModelType {
    struct Input {
        let loadTrigger: Driver<Void>
        let backTrigger: Driver<Void>
        let playButtonTrigger: Driver<Void>
        let favoriteSelectTrigger: Driver<Void>
    }
    
    struct Output {
        let movieDetail: Driver<MovieDetail>
        let actors: Driver<[Actor]>
        let error: Driver<Error>
        let indicator: Driver<Bool>
        let selectedPlayButton: Driver<Void>
        let back: Driver<Void>
        let checkMovieExistOnDatabase: Driver<Bool>
        let addFavourite: Driver<Void>
    }
    
    func transform(_ input: Input) -> Output {
        let indicator = ActivityIndicator()
        let error = ErrorTracker()
        let movieDetail = input.loadTrigger
            .flatMapLatest { _ in
                self.useCase.getMovieDetail()
                    .trackError(error)
                    .trackActivity(indicator)
                    .asDriverOnErrorJustComplete()
            }
        
        let actors = input.loadTrigger
            .flatMapLatest { _ in
                self.useCase.getActorsOfMove()
                    .trackError(error)
                    .trackActivity(indicator)
                    .asDriverOnErrorJustComplete()
            }
        
        let back = input.backTrigger
            .do(onNext: self.navigator.back)
        
        let playTrailerTrigger = Driver.combineLatest(input.playButtonTrigger, movieDetail)
        
        let selectedPlayButton = playTrailerTrigger
            .do(onNext: { (_, movieDetail) in
                guard let key = movieDetail.keyYoutubeTrailer else {
                    return
                }
                self.navigator.toPlayTrailer(keyYoutube: key)
            })
            .mapToVoid()
        
        let addFavouriteTrigger = Driver.combineLatest(input.favoriteSelectTrigger, movieDetail)
        let addFavouriteMovie = addFavouriteTrigger
            .do(onNext: { _, movieDetail in
                self.useCase.addOrRemoveFavouriteMovie(movie: movieDetail)
            })
            .mapToVoid()
        
        let checkTrigger = Driver.combineLatest(input.favoriteSelectTrigger, addFavouriteMovie)
            .map {
                return $0.1
            }
        
        let checkMovieExistTrigger = Driver.merge(input.loadTrigger, checkTrigger)
        
        let checkMovieExistOnDatabase = checkMovieExistTrigger
            .flatMapLatest { _ in
                self.useCase.checkMovieExistOnDatabase()
                    .asDriverOnErrorJustComplete()
            }
            
        return Output(movieDetail: movieDetail,
                      actors: actors,
                      error: error.asDriver(),
                      indicator: indicator.asDriver(),
                      selectedPlayButton: selectedPlayButton,
                      back: back,
                      checkMovieExistOnDatabase: checkMovieExistOnDatabase,
                      addFavourite: addFavouriteMovie)
    }
}
