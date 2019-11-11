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
    
    // MARK: - View Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        config()
    }
    
    // MARK - Support Modethods
    private func config() {
         let layout = UICollectionViewFlowLayout().then {
             $0.minimumInteritemSpacing = 5
             $0.sectionInset = UIEdgeInsets(top: 0, left: 7, bottom: 0, right: 7)
             let itemHeight = topRatedCollectionView.height
             let itemRow = CGFloat(1.5)
             let itemWidth = $0.estimateWitdhOfCell(itemRow: itemRow)
             $0.itemSize = CGSize(width: itemWidth, height: itemHeight)
             $0.scrollDirection = .horizontal
         }
         topRatedCollectionView.register(cellType: TopRatedCell.self)
         topRatedCollectionView.register(cellType: MoreCell.self)
         topRatedCollectionView.collectionViewLayout = layout
    }
    
    func bindViewModel() {
        let dataSource =  self.datasource()
        let input = MovieViewModel.Input(
            loadTrigger: Driver.just(())
        )
        let output = viewModel.transform(input)
        output.cellData
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
