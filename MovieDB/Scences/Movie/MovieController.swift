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
        [topRatedCollectionView, nowPlayingCollectionView].forEach {
            $0?.register(cellType: TopRatedCell.self)
            $0?.register(cellType: MoreCell.self)
            $0?.register(cellType: NowPlayingCell.self)
        }
        configFlowLayout(topRatedCollectionView, topRatedLayoutInfo)
        configFlowLayout(nowPlayingCollectionView, nowPlayingLayoutInfo)
    }
    
    func bindViewModel() {
        let topRatedDatasource =  datasource()
        let nowPlayingDatasource = datasource()
        let input = MovieViewModel.Input(
            loadTrigger: Driver.just(())
        )
        let output = viewModel.transform(input)
        output.topRated
            .map {
                $0.map {
                    SectionModel(model: $0.header, items: $0.items)
                }
            }
            .drive(topRatedCollectionView.rx.items(dataSource: topRatedDatasource))
            .disposed(by: rx.disposeBag)
        output.nowPlaying
            .map {
                $0.map {
                    SectionModel(model: $0.header, items: $0.items)
                }
            }
            .drive(nowPlayingCollectionView.rx.items(dataSource: nowPlayingDatasource))
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
    func datasource() -> RxCollectionViewSectionedReloadDataSource<SectionModel<String, MovieViewModel.CellType>> {
        return RxCollectionViewSectionedReloadDataSource<SectionModel<String, MovieViewModel.CellType>>(configureCell: { dataSource, collectionView, indexPath, item in
            switch item {
            case .MoreMovieCell:
                let cell: MoreCell = collectionView.dequeueReusableCell(for: indexPath)
                return cell
            case .TopRatedCell(let topRated):
                let cell: TopRatedCell = collectionView.dequeueReusableCell(for: indexPath)
                cell.setContentCell(topRated: topRated)
                return cell
            case .NowPlayingCell(let nowPlaying):
                let cell: NowPlayingCell = collectionView.dequeueReusableCell(for: indexPath)
                cell.setContentCell(nowPlaying: nowPlaying)
                return cell
            }
        }, configureSupplementaryView: {_, _, _, _  in return UICollectionReusableView()})
    }
}


