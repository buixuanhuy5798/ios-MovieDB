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
    }
    
    struct Output {
        let categories: Driver<[Category]>
        let error: Driver<Error>
        let indicator: Driver<Bool>
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
        
        return Output(
            categories: categories,
            error: error.asDriver(),
            indicator: indicator.asDriver()
        )
    }
}
