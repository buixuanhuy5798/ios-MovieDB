//
//  AppDelegate.swift
//  MovieDB
//
//  Created by Bùi Xuân Huy on 10/23/19.
//  Copyright © 2019 huy. All rights reserved.
//

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        bindViewModel()
        return true
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

