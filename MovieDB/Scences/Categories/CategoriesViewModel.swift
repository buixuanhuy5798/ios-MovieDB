//
//  CategoriesViewModel.swift
//  MovieDB
//
//  Created by Bùi Xuân Huy on 11/22/19.
//  Copyright © 2019 huy. All rights reserved.
//

struct CategoriesViewModel {
    let navigator: CategoriesNavigatorType
    let useCase: CategoriesUseCaseType
}

extension CategoriesViewModel: ViewModelType {
    struct Input {
        let loadTrigger: Driver<Void>
        let selectCategory: Driver<IndexPath>
    }
    
    struct Output {
        let categories: Driver<[Category]>
        let error: Driver<Error>
        let indicator: Driver<Bool>
        let categorySelected: Driver<Void>
    }
    
    func transform(_ input: Input) -> Output {
        let indicator = ActivityIndicator()
        let error = ErrorTracker()
        
        let categories = input.loadTrigger
            .flatMapLatest { _ in
                return self.useCase.getCategories()
                    .trackError(error)
                    .trackActivity(indicator)
                    .asDriverOnErrorJustComplete()
            }
        
        let categorySelected = input.selectCategory
            .withLatestFrom(categories) { indexPath, categories in
                categories[indexPath.row]
            }
            .do(onNext: {
                self.navigator.toMoreMovie(catgory: $0)
            })
            .mapToVoid()
        
        return Output(
            categories: categories,
            error: error.asDriver(),
            indicator: indicator.asDriver(),
            categorySelected: categorySelected
        )
    }
}
