//
//  MovieDetailNavigator.swift
//  MovieDB
//
//  Created by Bùi Xuân Huy on 11/25/19.
//  Copyright © 2019 huy. All rights reserved.
//

protocol MovieDetailNavigatorType {
    func back()
    func toPlayTrailer(keyYoutube: String)
}

struct MovieDetailNavigator: MovieDetailNavigatorType {
    unowned let navigation: UINavigationController
    
    func back() {
        navigation.popViewController(animated: true)
    }
    
    func toPlayTrailer(keyYoutube: String) {
        let controller = PlayVideoTrailerController.instantiate()
        let useCase = PlayVideoTrailerUseCase()
        let navigator = PlayVideoTrailerNavigator(navigation: navigation)
        let viewModel = PlayVideoTrailerViewModel(navigator: navigator,
                                                  useCase: useCase,
                                                  keyYoutube: keyYoutube)
        controller.bindViewModel(to: viewModel)
        navigation.pushViewController(controller, animated: true)
    }
}
