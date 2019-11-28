//
//  PlayVideoTrailerViewModel.swift
//  MovieDB
//
//  Created by Bùi Xuân Huy on 11/27/19.
//  Copyright © 2019 huy. All rights reserved.
//

struct PlayVideoTrailerViewModel {
    let navigator: PlayVideoTrailerNavigatorType
    let useCase: PlayVideoTrailerUseCaseType
    let keyYoutube: String
}

extension PlayVideoTrailerViewModel: ViewModelType {
    struct Input {
        let loadTrigger: Driver<Void>
        let backTrigger: Driver<Void>
    }
    
    struct Output {
        let keyYoutube: Driver<String>
        let back: Driver<Void>
    }
    
    func transform(_ input: Input) -> Output {
        let keyYoutube = input.loadTrigger.map {
            self.keyYoutube
        }
        
        let back = input.backTrigger
            .do (onNext: self.navigator.back)
        
        return Output(keyYoutube: keyYoutube, back: back)
    }
}
