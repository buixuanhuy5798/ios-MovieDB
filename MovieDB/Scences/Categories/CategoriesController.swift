//
//  CategoriesController.swift
//  MovieDB
//
//  Created by Bùi Xuân Huy on 10/24/19.
//  Copyright © 2019 huy. All rights reserved.
//

final class CategoriesController: UIViewController, BindableType {
    
    // MARK: - Outlets
    @IBOutlet private weak var categoriesTableView: UITableView!
    
    // MARK: - Variables
    var viewModel: CategoriesViewModel!
    
    // MARK: - ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configTableView()
    }
    
    // MARK: - Support Methods
    func configTableView() {
        categoriesTableView.register(cellType: CategoriesCell.self)
        categoriesTableView.rx
            .setDelegate(self)
            .disposed(by: rx.disposeBag)
    }
    
    func bindViewModel() {
        let input = CategoriesViewModel.Input(
            loadTrigger: Driver.just(())
        )
        let output = viewModel.transform(input)
        output.categories
            .drive(categoriesTableView.rx.items) { tableView, index, item in
                let indexPath = IndexPath(item: index, section: 0)
                let cell: CategoriesCell = tableView.dequeueReusableCell(for: indexPath)
                cell.setContentForCell(category: item)
                return cell
            }
            .disposed(by: rx.disposeBag)
        output.error
            .drive()
            .disposed(by: rx.disposeBag)
        output.indicator
            .drive()
            .disposed(by: rx.disposeBag)
    }
}

extension CategoriesController: StoryboardSceneBased {
    static var sceneStoryboard = Storyboards.categories
}

extension CategoriesController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.height / 5
    }
}
