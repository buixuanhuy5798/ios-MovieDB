//
//  SearchMovieController.swift
//  MovieDB
//
//  Created by Bùi Xuân Huy on 11/27/19.
//  Copyright © 2019 huy. All rights reserved.
//

final class SearchMovieController: UIViewController, BindableType {

    // MARK: - Outlets
    @IBOutlet private weak var backButton: UIButton!
    @IBOutlet private weak var searchBar: UISearchBar!
    @IBOutlet private weak var resultTableView: LoadMoreTableView!
    
    // MARK: - Variables
    var viewModel: SearchMovieViewModel!
    
    // MARK: - View Life Cycles
    override func viewDidLoad() {
        configView()
    }
    
    // MARK: - Support Methods
    private func configView() {
        resultTableView.register(cellType: SearchResultCell.self)
        resultTableView.rx
            .setDelegate(self)
            .disposed(by: rx.disposeBag)
        self.hideKeyboardWhenTappedAround()
    }
    
    func bindViewModel() {
        let input = SearchMovieViewModel.Input(
            reloadTrigger: resultTableView.refreshTrigger,
            loadMoreTrigger: resultTableView.loadMoreTrigger,
            backTrigger: backButton.rx.tap.asDriver(),
            textSearch: searchBar.rx.text.orEmpty.asDriver(),
            selectResult: resultTableView.rx.itemSelected.asDriver())
        let output = viewModel.transform(input)
        output.searchResult
            .drive(resultTableView.rx.items) { tableview, index, items in
                let indexPath = IndexPath(item: index, section: 0)
                let cell: SearchResultCell = tableview.dequeueReusableCell(for: indexPath)
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
            .drive(resultTableView.refreshing)
            .disposed(by: rx.disposeBag)
        output.loadMore
            .drive(resultTableView.loadingMore)
            .disposed(by: rx.disposeBag)
        output.resultSelected
            .drive()
            .disposed(by: rx.disposeBag)
        output.selectedBack
            .drive()
            .disposed(by: rx.disposeBag)
    }
    
}
    
extension SearchMovieController: StoryboardSceneBased {
    static var sceneStoryboard = Storyboards.searchMovie
}

extension SearchMovieController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}
