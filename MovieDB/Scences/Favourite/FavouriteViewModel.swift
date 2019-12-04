//
//  FavouriteViewModel.swift
//  MovieDB
//
//  Created by Bùi Xuân Huy on 11/28/19.
//  Copyright © 2019 huy. All rights reserved.
//

struct FavouriteViewModel {
    let navigator: FavouriteNavigatorType
    let useCase: FavouriteUseCaseType
}

extension FavouriteViewModel: ViewModelType {
    struct Input {
        let loadTrigger: Driver<Void>
        let removeAllSelect: Driver<Void>
        let selectMovie: Driver<IndexPath>
    }
    
    struct Output {
        let movie: Driver<[MovieShortenDetail]>
        let selectedRemoveAll: Driver<Void>
        let selectedMovie: Driver<Void>
    }
    
    func transform(_ input: FavouriteViewModel.Input) -> FavouriteViewModel.Output {
        let movieList = input.loadTrigger
            .flatMapLatest { _  in
                self.useCase.getAllFavouriteMovie()
                    .asDriverOnErrorJustComplete()
            }
        
        let selectedRemoveAll = input.removeAllSelect
            .do(onNext: self.useCase.removeAllFavouriteMovie)
            .mapToVoid()
        
        let selectedMovie = input.selectMovie
            .withLatestFrom(movieList) { indexPath, movieList in
                return movieList[indexPath.row]
            }
            .do(onNext: {
                self.navigator.toMovieDetailScreen(movieId: $0.id)
            })
            .mapToVoid()
            
        return Output(movie: movieList,
                      selectedRemoveAll: selectedRemoveAll,
                      selectedMovie: selectedMovie)
    }
}
