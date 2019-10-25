//
//  MovieController.swift
//  MovieDB
//
//  Created by Bùi Xuân Huy on 10/24/19.
//  Copyright © 2019 huy. All rights reserved.
//

final class MovieController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}

extension MovieController: StoryboardSceneBased {
    static var sceneStoryboard = Storyboards.movie
}
