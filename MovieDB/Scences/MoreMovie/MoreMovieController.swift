//
//  MoreMovieController.swift
//  MovieDB
//
//  Created by Bùi Xuân Huy on 11/28/19.
//  Copyright © 2019 huy. All rights reserved.
//

final class MoreMovieController: UIViewController, BindableType {
    
    @IBOutlet private weak var typeMovieLabel: UILabel!
    @IBOutlet private weak var backButton: UIButton!
    @IBOutlet private weak var movieListCollectionView: LoadMoreCollectionView!
    
    var viewModel: MoreMovieViewModel!
    private var movieLayoutInfo = CollectionViewLayout(itemSpacing: 7, itemsPerRow: 2)
    
    override func viewDidLoad() {
        configView()
    }
    
    private func configView() {
        let layout = UICollectionViewFlowLayout().then {
            let itemHeight = movieListCollectionView.height / 2.3
            let itemWitdh = movieLayoutInfo.estimateWitdhPerItems()
            $0.scrollDirection = .vertical
            $0.sectionInset = movieLayoutInfo.sectionInset
            $0.minimumInteritemSpacing = movieLayoutInfo.itemsSpacing
            $0.itemSize = CGSize(width: itemWitdh, height: itemHeight)
        }
        movieListCollectionView.collectionViewLayout = layout
        movieListCollectionView.register(cellType: MovieCell.self)
    }
    
    func bindViewModel() {
        let input = MoreMovieViewModel.Input(
            loadTrigger: Driver.just(()),
            reloadTrigger: movieListCollectionView.refreshTrigger,
            loadMoreTrigger: movieListCollectionView.loadMoreTrigger,
            selectBack: backButton.rx.tap.asDriver())
        let output = viewModel.transform(input)
        output.selectedBack
            .drive()
            .disposed(by: rx.disposeBag)
        output.title
            .do(onNext: {print ($0)})
            .drive(typeMovieLabel.rx.text)
            .disposed(by: rx.disposeBag)
        output.movieList
            .drive(movieListCollectionView.rx.items) { collectionview, index, items in
                let indexPath = IndexPath(item: index, section: 0)
                let cell: MovieCell = collectionview.dequeueReusableCell(for: indexPath)
                cell.setContentForCell(movieDetail: items)
                return cell
            }
            .disposed(by: rx.disposeBag)
        output.fetchItems
            .drive()
            .disposed(by: rx.disposeBag)
        output.error
            .drive(rx.error)
            .disposed(by: rx.disposeBag)
        output.indicator
            .drive(rx.isLoading)
            .disposed(by: rx.disposeBag)
        output.refreshing
            .drive(movieListCollectionView.refreshing)
            .disposed(by: rx.disposeBag)
        output.loadMore
            .drive(movieListCollectionView.loadingMore)
            .disposed(by: rx.disposeBag)
    }
}

extension MoreMovieController: StoryboardSceneBased {
    static var sceneStoryboard = Storyboards.moreMovie
}
