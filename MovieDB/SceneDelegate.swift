//
//  SceneDelegate.swift
//  MovieDB
//
//  Created by Bùi Xuân Huy on 10/23/19.
//  Copyright © 2019 huy. All rights reserved.
//

@available(iOS 13.0, *)
class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        bindViewModel()
    }
    
    private func bindViewModel() {
        guard let window = window else { return }
        let navigator = AppNavigator(window: window)
        let useCase = AppUseCase()
        let viewModel = AppViewModel(useCase: useCase, navigator: navigator)
        let input = AppViewModel.Input(loadTrigger: Driver.just(()))
        let output = viewModel.transform(input)
        output.toMain
            .drive()
            .disposed(by: rx.disposeBag)
    }
}

