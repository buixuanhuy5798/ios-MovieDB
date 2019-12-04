//
//  FavouriteUseCase.swift
//  MovieDB
//
//  Created by Bùi Xuân Huy on 11/28/19.
//  Copyright © 2019 huy. All rights reserved.
//

protocol FavouriteUseCaseType {
    func getAllFavouriteMovie() -> Observable<[MovieShortenDetail]>
    func removeAllFavouriteMovie()
}

struct FavouriteUseCase: FavouriteUseCaseType {
    let repository = FavouriteRepository()
    
    func getAllFavouriteMovie() -> Observable<[MovieShortenDetail]> {
        return repository.getAllFavouriteMovie()
    }
    
    func removeAllFavouriteMovie() {
        return repository.removeAllMovie()
    }
}
