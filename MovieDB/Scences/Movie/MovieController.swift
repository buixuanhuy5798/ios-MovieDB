//
//  MovieController.swift
//  MovieDB
//
//  Created by Bùi Xuân Huy on 10/24/19.
//  Copyright © 2019 huy. All rights reserved.
//

final class MovieController: UIViewController, BindableType {
    
    // MARK: - Outlets
    @IBOutlet private weak var topRatedCollectionView: UICollectionView!
    @IBOutlet private weak var nowPlayingCollectionView: UICollectionView!
    @IBOutlet private weak var popularCollectionView: UICollectionView!
    
    // MARK: - Variables
    var viewModel: MovieViewModel!
    private var topRatedLayoutInfo = CollectionViewLayout(itemSpacing: 7, itemsPerRow: 1.5)
    private var nowPlayingLayoutInfo = CollectionViewLayout(itemSpacing: 7, itemsPerRow: 2.2)
    
    // MARK: - View Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        config()
    }
    
    // MARK: - Support Modethods
    private func configFlowLayout(_ collectionView: UICollectionView,
                                  _ collectionViewLayoutInfo: CollectionViewLayout) {
        let layout = UICollectionViewFlowLayout().then {
            let itemHeight = collectionView.height
            let itemWitdh = collectionViewLayoutInfo.estimateWitdhPerItems()
            $0.itemSize = CGSize(width: itemWitdh, height: itemHeight)
            $0.minimumLineSpacing = collectionViewLayoutInfo.itemsSpacing
            $0.sectionInset = collectionViewLayoutInfo.sectionInset
            $0.scrollDirection = .horizontal
        }
        collectionView.collectionViewLayout = layout
    }
    
    private func config() {
        [topRatedCollectionView,
         nowPlayingCollectionView,
         popularCollectionView].forEach {
            $0?.register(cellType: TopRatedCell.self)
            $0?.register(cellType: MoreCell.self)
            $0?.register(cellType: NowPlayingCell.self)
            $0?.register(cellType: PopularCell.self)
        }
        configFlowLayout(topRatedCollectionView, topRatedLayoutInfo)
        configFlowLayout(nowPlayingCollectionView, nowPlayingLayoutInfo)
        configFlowLayout(popularCollectionView, nowPlayingLayoutInfo)
    }
    
    func bindViewModel() {
        let topRatedDatasource =  datasource()
        let nowPlayingDatasource = datasource()
        let popularDatasource = datasource()
        let input = MovieViewModel.Input(
            loadTrigger: Driver.just(()),
            selectTopRatedTrigger: topRatedCollectionView.rx.itemSelected.asDriver(),
            selectNowPlayingTrigger: nowPlayingCollectionView.rx.itemSelected.asDriver(),
            selectPopularTrigger: popularCollectionView.rx.itemSelected.asDriver()
        )
        
        let output = viewModel.transform(input)
        output.topRated
            .drive(topRatedCollectionView.rx.items(dataSource: topRatedDatasource))
            .disposed(by: rx.disposeBag)
        output.nowPlaying
            .drive(nowPlayingCollectionView.rx.items(dataSource: nowPlayingDatasource))
            .disposed(by: rx.disposeBag)
        output.popular
            .drive(popularCollectionView.rx.items(dataSource: popularDatasource))
            .disposed(by: rx.disposeBag)
        output.nowPlayingSelected
            .drive()
            .disposed(by: rx.disposeBag)
        output.topRatedSelected
            .drive()
            .disposed(by: rx.disposeBag)
        output.popularSelected
            .drive()
            .disposed(by: rx.disposeBag)
        output.indicator
            .drive(rx.isLoading)
            .disposed(by: rx.disposeBag)
        output.error
            .drive(rx.error)
            .disposed(by: rx.disposeBag)
    }
}

extension MovieController: StoryboardSceneBased {
    static var sceneStoryboard = Storyboards.movie
}

extension MovieController {
    func datasource() -> RxCollectionViewSectionedReloadDataSource<SectionModel<String, DataMovie>> {
        return RxCollectionViewSectionedReloadDataSource<SectionModel<String, DataMovie>>(configureCell: { dataSource, collectionView, indexPath, item in
            switch item {
            case .more:
                let cell: MoreCell = collectionView.dequeueReusableCell(for: indexPath)
                return cell
            case .topRated(let topRated):
                let cell: TopRatedCell = collectionView.dequeueReusableCell(for: indexPath)
                cell.setContentCell(topRated: topRated)
                return cell
            case .nowPlaying(let nowPlaying):
                let cell: NowPlayingCell = collectionView.dequeueReusableCell(for: indexPath)
                cell.setContentCell(nowPlaying: nowPlaying)
                return cell
            case .popular(let popular):
                let cell: PopularCell = collectionView.dequeueReusableCell(for: indexPath)
                cell.setContentCell(popular: popular)
                return cell
            }
        }, configureSupplementaryView: {_, _, _, _  in return UICollectionReusableView()})
    }
}


