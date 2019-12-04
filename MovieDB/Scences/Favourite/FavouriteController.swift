//
//  FavouriteController.swift
//  MovieDB
//
//  Created by Bùi Xuân Huy on 10/24/19.
//  Copyright © 2019 huy. All rights reserved.
//

final class FavouriteController: UIViewController, BindableType {
 
    // MARK: - Outlets
    @IBOutlet weak var favouriteMovieCollectionView: UICollectionView!
    @IBOutlet weak var removeAllButton: UIButton!
    
    // MARK: - Variables
    var viewModel: FavouriteViewModel!
    private var movieLayoutInfo = CollectionViewLayout(itemSpacing: 7, itemsPerRow: 2)
    
    // MARK: - View Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
    }
    
    // MARK: - Support Methods
    private func configView() {
        let layout = UICollectionViewFlowLayout().then {
            let itemHeight = favouriteMovieCollectionView.height / 2.3
            let itemWitdh = movieLayoutInfo.estimateWitdhPerItems()
            $0.scrollDirection = .vertical
            $0.sectionInset = movieLayoutInfo.sectionInset
            $0.minimumInteritemSpacing = movieLayoutInfo.itemsSpacing
            $0.itemSize = CGSize(width: itemWitdh, height: itemHeight)
        }
        favouriteMovieCollectionView.collectionViewLayout = layout
        favouriteMovieCollectionView.register(cellType: MovieCell.self)
    }
    
    func bindViewModel() {
        let input = FavouriteViewModel.Input(
            loadTrigger: Driver.just(()),
            removeAllSelect: removeAllButton.rx.tap.asDriver(),
            selectMovie: favouriteMovieCollectionView.rx.itemSelected.asDriver())
        let output = viewModel.transform(input)
        output.movie
            .drive(favouriteMovieCollectionView.rx.items) { collectionview, index, items in
                let indexPath = IndexPath(item: index, section: 0)
                let cell: MovieCell = collectionview.dequeueReusableCell(for: indexPath)
                cell.setContentForCell(movieDetail: items)
                return cell
            }
            .disposed(by: rx.disposeBag)
        output.selectedRemoveAll
            .drive()
            .disposed(by: rx.disposeBag)
        output.selectedMovie
            .drive()
            .disposed(by: rx.disposeBag)
    }
}

extension FavouriteController: StoryboardSceneBased {
    static var sceneStoryboard = Storyboards.favourite
}
