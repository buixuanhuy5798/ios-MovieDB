//
//  ViewController.swift
//  MovieDB
//
//  Created by Bùi Xuân Huy on 10/23/19.
//  Copyright © 2019 huy. All rights reserved.
//

final class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        config()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        presentStartedView()
    }
    
    private func presentStartedView() {
        if !UserDefaults.standard.bool(forKey: "notFirstLauchApp") {
            let viewModel = StartedViewModel()
            let startedController = StartedController.instantiate().then {
                $0.bindViewModel(to: viewModel)
                $0.modalPresentationStyle = .fullScreen
            }
            self.present(startedController, animated: true, completion: nil)
            UserDefaults.standard.set(true, forKey: "notFirstLauchApp")
        }
    }
    
    private func config() {
        self.hideNavigationBar()
    }
    
}

extension MainTabBarController: StoryboardSceneBased {
    static var sceneStoryboard = Storyboards.mainTabBar
}
