//
//  MoreMovieViewModel.swift
//  MovieDB
//
//  Created by Bùi Xuân Huy on 11/28/19.
//  Copyright © 2019 huy. All rights reserved.
//

struct MoreMovieViewModel {
    let navigator: MoreMovieNavigatorType
    let useCase: MoreMovieUseCaseType
    let type: MovieType
}

extension MoreMovieViewModel: ViewModelType {
    struct Input {
        let loadTrigger: Driver<Void>
        let reloadTrigger: Driver<Void>
        let loadMoreTrigger: Driver<Void>
        let selectBack: Driver<Void>
        let selectMovie: Driver<IndexPath>
    }
    
    struct Output {
        let movieList: Driver<[MovieShortenDetail]>
        let error: Driver<Error>
        let indicator: Driver<Bool>
        let refreshing: Driver<Bool>
        let loadMore: Driver<Bool>
        let fetchItems: Driver<Void>
        let selectedBack: Driver<Void>
        let title: Driver<String>
        let movieSelected: Driver<Void>
    }
    
    func transform(_ input: Input) -> Output {
        let loadTrigger = input.loadTrigger.map {
            self.type
        }
        
        let title = input.loadTrigger.map {
            self.type.title
        }
        
        let refreshTrigger = input.reloadTrigger
            .withLatestFrom(loadTrigger)
        
        let loadMoreTrigger = input.loadMoreTrigger
            .withLatestFrom(loadTrigger)
        
        let loadMoreOutput = setupLoadMorePagingWithParam(
            loadTrigger: loadTrigger,
            getItems: useCase.getMovieList,
            refreshTrigger: refreshTrigger,
            refreshItems: useCase.getMovieList,
            loadMoreTrigger: loadMoreTrigger,
            loadMoreItems: useCase.getMoreMovieList)
        
        let (page, fetchItems, error, indicator, refreshing, loadingMore) = loadMoreOutput
        
        let movieList = page
            .map { $0.items }
            .asDriverOnErrorJustComplete()
        
        let movieSelected = input.selectMovie
            .withLatestFrom(movieList) { indexPath, movieList in
                return movieList[indexPath.row]
            }
            .do(onNext: {
                self.navigator.toMovieDetailScreen(movieId: $0.id)
            })
            .mapToVoid()
        
        let selectedBack = input.selectBack
            .do(onNext: navigator.back)
            .mapToVoid()
        
        return Output(movieList: movieList,
                      error: error,
                      indicator: indicator,
                      refreshing: refreshing,
                      loadMore: loadingMore,
                      fetchItems: fetchItems,
                      selectedBack: selectedBack,
                      title: title,
                      movieSelected: movieSelected)
    }
}
