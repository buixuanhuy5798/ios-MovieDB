//
//  CategoriesRepository.swift
//  MovieDB
//
//  Created by Bùi Xuân Huy on 11/22/19.
//  Copyright © 2019 huy. All rights reserved.
//

protocol CategoriesRepositoryType {
    func getAllCategories() -> Observable<[Category]>
}

final class CategoriesRepository: CategoriesRepositoryType {
    
    func getAllCategories() -> Observable<[Category]> {
        let input = API.GetCategoriesInput()
        return API.shared.getCategories(input)
            .map { output in
                guard let categories = output.categories else {
                    throw APIInvalidResponseError()
                }
                return categories
            }
    }
}
