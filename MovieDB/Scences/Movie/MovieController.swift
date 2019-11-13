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
    
    // MARK: - Variables
    var viewModel: MovieViewModel!
    private var topRatedLayout = CollectionViewLayout(itemSpacing: 7, itemsPerRow: 1.5)
    
    // MARK: - View Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        config()
    }
    
    // MARK - Support Modethods
    private func config() {
        topRatedCollectionView.do {
            $0.register(cellType: TopRatedCell.self)
            $0.register(cellType: MoreCell.self)
            $0.rx
                .setDelegate(self)
                .disposed(by: rx.disposeBag)
        }
    }
    
    func bindViewModel() {
        let dataSource =  self.datasource()
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
        .drive(topRatedCollectionView.rx.items(dataSource: dataSource))
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
            }
        }, configureSupplementaryView: {_, _, _, _  in return UICollectionReusableView()})
    }
}

extension MovieController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == topRatedCollectionView {
            let itemHeight = collectionView.height
            let itemWitdh = topRatedLayout.estimateWitdhPerItems()
            return CGSize(width: itemWitdh, height: itemHeight)
        } else {
            return CGSize()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if collectionView == topRatedCollectionView {
            return topRatedLayout.sectionInset
        } else {
            return UIEdgeInsets()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
         if collectionView == topRatedCollectionView {
             return topRatedLayout.itemsSpacing
         } else {
             return CGFloat()
        }
    }
}
