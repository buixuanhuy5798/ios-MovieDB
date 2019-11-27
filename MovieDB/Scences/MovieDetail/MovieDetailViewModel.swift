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
    }
    
    struct Output {
        let movieDetail: Driver<MovieDetail>
        let actors: Driver<[Actor]>
        let overview: Driver<String>
        let posterImage: Driver<String>
        let backdropImage: Driver<String>
        let title: Driver<String>
        let voteCount: Driver<String>
        let voteAvarage: Driver<String>
        let runTime: Driver<String>
        let error: Driver<Error>
        let indicator: Driver<Bool>
        let back: Driver<Void>
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
        
        let title = movieDetail.map {
            $0.title
        }
        
        let overview = movieDetail.map {
            $0.overview
        }
        
        let voteCount = movieDetail.map {
            "Vote Count: \($0.voteCount)"
        }
        
        let voteAvarage = movieDetail.map {
            "\($0.voteAverage)"
        }
        
        let runtime = movieDetail.map {
            "Runtime: \($0.runTime)"
        }
        
        let posterImage = movieDetail.map {
            $0.posterImageUrl
        }
        
        let backdropImage = movieDetail.map {
            $0.backdropImageUrl
        }
        
        let back = input.backTrigger
            .do(onNext: self.navigator.back)
        
        return Output(movieDetail: movieDetail,
                      actors: actors,
                      overview: overview,
                      posterImage: posterImage,
                      backdropImage: backdropImage,
                      title: title,
                      voteCount: voteCount,
                      voteAvarage: voteAvarage,
                      runTime: runtime,
                      error: error.asDriver(),
                      indicator: indicator.asDriver(),
                      back: back)
    }
}
