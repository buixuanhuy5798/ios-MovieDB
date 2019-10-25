//
//  StartedViewModel.swift
//  MovieDB
//
//  Created by Bùi Xuân Huy on 10/25/19.
//  Copyright © 2019 huy. All rights reserved.
//

struct StartedViewModel: ViewModelType {
    
    struct Input {
        let nextTrigger: Driver<Void>
        let startedTrigger: Driver<Void>
    }
    
    struct Output {
        let scrollToNextPage: Driver<Void>
        let dismiss: Driver<Void>
    }
    
    func transform(_ input: Input) -> Output {
        let scrollToNextPage = input.nextTrigger
        let dismiss = input.startedTrigger
        return Output(scrollToNextPage: scrollToNextPage,
                      dismiss: dismiss)
    }
}
