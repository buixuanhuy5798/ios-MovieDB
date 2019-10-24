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
    
    private func config() {
        navigationController?.navigationBar.isHidden = true
    }
    
}

extension MainTabBarController: StoryboardSceneBased {
    static var sceneStoryboard = Storyboards.mainTabBar
}
