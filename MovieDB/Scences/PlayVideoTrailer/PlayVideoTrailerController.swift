//
//  PlayVideoTrailerController.swift
//  MovieDB
//
//  Created by Bùi Xuân Huy on 11/27/19.
//  Copyright © 2019 huy. All rights reserved.
//

import YouTubePlayer

final class PlayVideoTrailerController: UIViewController, BindableType {
    
    @IBOutlet private weak var youtubePlayerView: YouTubePlayerView!
    @IBOutlet private weak var indicatorView: UIView!
    @IBOutlet private weak var backButton: UIButton!
    
    var viewModel: PlayVideoTrailerViewModel!
    
    override func viewDidLoad() {
        youtubePlayerView.delegate = self
    }
    
    func bindViewModel() {
        let input = PlayVideoTrailerViewModel.Input(
            loadTrigger: Driver.just(()),
            backTrigger: backButton.rx.tap.asDriver()
        )
        
        let output = viewModel.transform(input)
        output.keyYoutube
            .drive(youtubePlayerView.rx.keyYoutube)
            .disposed(by: rx.disposeBag)
        output.back
            .drive()
            .disposed(by: rx.disposeBag)
    }
}

extension PlayVideoTrailerController: StoryboardSceneBased {
    static var sceneStoryboard = Storyboards.playYoutubeTrailer
}

extension PlayVideoTrailerController: YouTubePlayerDelegate {
    func playerReady(_ videoPlayer: YouTubePlayerView) {
        indicatorView.isHidden = true
    }
}

extension Reactive where Base: YouTubePlayerView {
    var keyYoutube: Binder<String> {
        return Binder(self.base) { playerView, keyYoutube in
            playerView.loadVideoID(keyYoutube)
        }
    }
}
