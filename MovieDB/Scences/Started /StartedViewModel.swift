//
//  StartedViewModel.swift
//  MovieDB
//
//  Created by Bùi Xuân Huy on 10/25/19.
//  Copyright © 2019 huy. All rights reserved.
//

struct StartedViewModel {
    let navigator: StartedNavigatorType
}

extension StartedViewModel: ViewModelType {
    
    struct Input {
        let tapNextButton: Driver<Void>
        let tapStartedButton: Driver<Void>
    }
    
    struct Output {
        let scrollToNextPage: Driver<Void>
        let toMainTabBar: Driver<Void>
    }
    
    func transform(_ input: Input) -> Output {
        let scrollToNextPage = input.tapNextButton
        let toMainTabBar = input.tapStartedButton
            .do(onNext: self.navigator.toMainTabBar)
        return Output(
            scrollToNextPage: scrollToNextPage,
            toMainTabBar: toMainTabBar
        )
    }
}
