//
//  MovieDetailController.swift
//  MovieDB
//
//  Created by Bùi Xuân Huy on 11/27/19.
//  Copyright © 2019 huy. All rights reserved.
//

final class MovieDetailController: UIViewController, BindableType {
    
    // MARK - Outlets
    
    @IBOutlet private weak var backButton: UIButton!
    @IBOutlet private weak var favouriteButton: UIButton!
    @IBOutlet private weak var actorCollectionView: UICollectionView!
    @IBOutlet private weak var overviewLabel: UILabel!
    @IBOutlet private weak var voteAverageLabel: UILabel!
    @IBOutlet private weak var voteCountLabel: UILabel!
    @IBOutlet private weak var runTimeLabel: UILabel!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var posterImageView: UIImageView!
    @IBOutlet private weak var backDropImageView: UIImageView!
    
    // MARK: - Variables
    var viewModel: MovieDetailViewModel!
    private var actorsLayoutInfo = CollectionViewLayout(itemSpacing: 7, itemsPerRow: 3.5)
    
    // MARK: - View Life Cycles
    override func viewDidLoad() {
        configCollectionView()
    }
    
    private func configCollectionView() {
        let layout = UICollectionViewFlowLayout().then {
            let itemHeight = actorCollectionView.height
            let itemWitdh = actorsLayoutInfo.estimateWitdhPerItems()
            $0.scrollDirection = .horizontal
            $0.sectionInset = actorsLayoutInfo.sectionInset
            $0.minimumInteritemSpacing = actorsLayoutInfo.itemsSpacing
            $0.itemSize = CGSize(width: itemWitdh, height: itemHeight)
        }
        actorCollectionView.collectionViewLayout = layout
        actorCollectionView.register(cellType: ActorCell.self)
    }
    
    func bindViewModel() {
        let input = MovieDetailViewModel.Input(
                        loadTrigger: Driver.just(()),
                        backTrigger: backButton.rx.tap.asDriver()
                    )
        let output = viewModel.transform(input)
        output.movieDetail
            .drive()
            .disposed(by: rx.disposeBag)
        output.actors
            .drive(actorCollectionView.rx.items) { collectionview, index, item in
                let indexPath = IndexPath(item: index, section: 0)
                let cell: ActorCell = collectionview.dequeueReusableCell(for: indexPath)
                cell.setContentForCell(actor: item)
                return cell
            }
            .disposed(by: rx.disposeBag)
        output.title
            .drive(titleLabel.rx.text)
            .disposed(by: rx.disposeBag)
        output.posterImage
            .drive(posterImageView.rx.imageUrl)
            .disposed(by: rx.disposeBag)
        output.backdropImage
            .drive(backDropImageView.rx.imageUrl)
            .disposed(by: rx.disposeBag)
        output.overview
            .drive(overviewLabel.rx.text)
            .disposed(by: rx.disposeBag)
        output.voteCount
            .drive(voteCountLabel.rx.text)
            .disposed(by: rx.disposeBag)
        output.runTime
            .drive(runTimeLabel.rx.text)
            .disposed(by: rx.disposeBag)
        output.voteAvarage
            .drive(voteAverageLabel.rx.text)
            .disposed(by: rx.disposeBag)
        output.back
            .drive()
            .disposed(by: rx.disposeBag)
        output.error
            .drive()
            .disposed(by: rx.disposeBag)
        output.indicator
            .drive()
            .disposed(by: rx.disposeBag)
    }
}

extension MovieDetailController: StoryboardSceneBased {
    static var sceneStoryboard = Storyboards.movieDetail
}

