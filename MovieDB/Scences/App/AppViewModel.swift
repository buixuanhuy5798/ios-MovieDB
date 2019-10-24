//
//  AppViewModel.swift
//  MovieDB
//
//  Created by Bùi Xuân Huy on 10/24/19.
//  Copyright © 2019 huy. All rights reserved.
//

struct AppViewModel {
    var useCase: AppUseCaseType
    var navigator: AppNavigatorType
}

extension AppViewModel: ViewModelType {
    struct Input {
        let loadTrigger: Driver<Void>
    }
    
    struct Output {
        let toMain: Driver<Void>
    }
    
    func transform(_ input: Input) -> Output {
        let toMain = input.loadTrigger
            .do(onNext: self.navigator.toMain)
        return Output(toMain: toMain)
    }
}
