//
//  MovieViewModel.swift
//  MovieDB
//
//  Created by Bùi Xuân Huy on 11/11/19.
//  Copyright © 2019 huy. All rights reserved.
//

struct MovieViewModel {
    let navigator: MovieNavigatorType
    let useCase: MovieUseCaseType
}

extension MovieViewModel: ViewModelType {
    struct Constants {
        static let defaultNumberOfMovie = 7
    }
    
    enum CellType {
        case MoreMovieCell
        case TopRatedCell(topRated: TopRated)
    }
    
    struct SectionOfCustomData {
        var header: String
        var items: [CellType]
    }
    
    struct Input {
        let loadTrigger: Driver<Void>
    }
    
    struct Output {
        let cellData: Driver<[SectionOfCustomData]>
        let error: Driver<Error>
        let indicator: Driver<Bool>
    }
    
    func transform(_ input: Input) -> Output {
        let indicator = ActivityIndicator()
        let error = ErrorTracker()
        let topRatedList = input.loadTrigger
               .flatMapLatest { _ in
                   return self.useCase.getTopRatedMovie()
                        .trackActivity(indicator)
                        .trackError(error)
                        .map {
                            return $0.items.prefix(Constants.defaultNumberOfMovie).map {
                                return CellType.TopRatedCell(topRated: $0)
                            }
                        }
                        .map {
                            return SectionOfCustomData(header: "", items: $0)
                        }
                       .asDriverOnErrorJustComplete()
               }
        let loadMoreCell = input.loadTrigger
            .map {
                return SectionOfCustomData(header: "", items: [CellType.MoreMovieCell])
            }
        let sections = Driver.combineLatest(topRatedList, loadMoreCell) {
            return [$0, $1]
        }
        return Output(
            cellData: sections,
            error: error.asDriver(),
            indicator: indicator.asDriver()
        )
    }
    
}

