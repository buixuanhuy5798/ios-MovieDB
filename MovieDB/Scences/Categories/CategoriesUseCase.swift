//
//  CategoriesUseCase.swift
//  MovieDB
//
//  Created by Bùi Xuân Huy on 11/22/19.
//  Copyright © 2019 huy. All rights reserved.
//

protocol CategoriesUseCaseType {
    func getCategories() -> Observable<[Category]>
}

struct CategoriesUseCase: CategoriesUseCaseType {
    let repository = CategoriesRepository()
    
    func getCategories() -> Observable<[Category]> {
        return repository.getAllCategories()
    }
}
