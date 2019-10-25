//
//  StartedController.swift
//  MovieDB
//
//  Created by Bùi Xuân Huy on 10/25/19.
//  Copyright © 2019 huy. All rights reserved.
//

final class StartedController: UIViewController, BindableType {

    @IBOutlet private weak var scrollView: UIScrollView!
    @IBOutlet private weak var nextButton: RoundedButton!
    @IBOutlet private weak var secondNextButton: RoundedButton!
    @IBOutlet private weak var getStartedButton: RoundedButton!
    
    var viewModel: StartedViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func bindViewModel() {
        let input = StartedViewModel.Input(nextTrigger: Driver.merge(nextButton.rx.tap.asDriver(),
                                                                     secondNextButton.rx.tap.asDriver()),
                                           startedTrigger: getStartedButton.rx.tap.asDriver())
        let output = viewModel.transform(input)
        output.scrollToNextPage
            .do(onNext: configScroll)
            .drive()
            .disposed(by: rx.disposeBag)
        output.dismiss
            .do(onNext: {
                self.dismiss(animated: true, completion: nil)
            })
            .drive()
            .disposed(by: rx.disposeBag)
    }
    
    private func configScroll() {
        scrollView.contentOffset.x +=
                           view.witdh
    }
}

extension StartedController: StoryboardSceneBased {
    static var sceneStoryboard = Storyboards.started
}
