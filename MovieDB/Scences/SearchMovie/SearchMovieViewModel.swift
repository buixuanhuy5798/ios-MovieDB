//
//  SearchMovieViewModel.swift
//  MovieDB
//
//  Created by Bùi Xuân Huy on 11/27/19.
//  Copyright © 2019 huy. All rights reserved.
//

struct SearchMovieViewModel {
    let navigator: SearchMovieNavigatorType
    let useCase: SearchMovieUseCaseType
}

extension SearchMovieViewModel: ViewModelType {
    struct Input {
        let reloadTrigger: Driver<Void>
        let loadMoreTrigger: Driver<Void>
        let backTrigger: Driver<Void>
        let textSearch: Driver<String>
        let selectResult: Driver<IndexPath>
    }
    
    struct Output {
        let searchResult: Driver<[MovieDetail]>
        let error: Driver<Error>
        let indicator: Driver<Bool>
        let refreshing: Driver<Bool>
        let loadMore: Driver<Bool>
        let fetchItems: Driver<Void>
        let selectedBack: Driver<Void>
        let resultSelected: Driver<Void>
        let back: Driver<Void>
    }
    
    func transform(_ input: Input) -> Output {
        let textResult = input.textSearch
            .debounce(0.75)
            .distinctUntilChanged()
            .filter { !$0.isEmpty }
            .asDriver()

        let refreshTrigger = input.reloadTrigger
            .withLatestFrom(textResult)
        
        let loadMoreTrigger = input.loadMoreTrigger
            .withLatestFrom(textResult)
        
        let loadMoreOutput = setupLoadMorePagingWithParam(
            loadTrigger: textResult,
            getItems: useCase.getSearchResult,
            refreshTrigger: refreshTrigger,
            refreshItems: useCase.getSearchResult,
            loadMoreTrigger: loadMoreTrigger,
            loadMoreItems: useCase.getMoreSearchResults)
        
        let (page, fetchItems, error, indicator, refreshing, loadingMore) = loadMoreOutput
        
        let searchResult = page
                   .map { $0.items }
                   .asDriverOnErrorJustComplete()
        
        let selectedBack = input.backTrigger
            .do(onNext: navigator.back)
        
        let resultSelected = input.selectResult
            .withLatestFrom(searchResult) { indexPath, searchResult in
                return searchResult[indexPath.row]
            }
            .do(onNext: {
                self.navigator.toMovieDetailScreen(movieId: $0.id)
            })
            .mapToVoid()
        
        let back = input.backTrigger
            .do(onNext: self.navigator.back)
        
        return Output(searchResult: searchResult,
                      error: error,
                      indicator: indicator,
                      refreshing: refreshing,
                      loadMore: loadingMore,
                      fetchItems: fetchItems,
                      selectedBack: selectedBack,
                      resultSelected: resultSelected,
                      back: back)
    }
}
