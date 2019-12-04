//
//  FavouriteRepository.swift
//  MovieDB
//
//  Created by Bùi Xuân Huy on 11/29/19.
//  Copyright © 2019 huy. All rights reserved.
//

import RealmSwift
import RxRealm

struct FavouriteRepository {

    let realmService = RealmService.shared
    let mapper = MapperMovie.shared
    
    func getAllFavouriteMovie() -> Observable<[MovieShortenDetail]> {
        let list = realmService.getAllData(listOf: MovieDetailRealm.self,
                                           sortByKey: "timeAdd")
            .map {
                $0.map {
                    self.mapper.realmToMovieDetail(realmModel: $0)
                }
            }
        return list
    }
    
    func addOrRemoveMovie(movie: MovieShortenDetail) {
        do {
            let realm = try Realm()
            try realm.write {
                guard let object = realm.object(
                    ofType: MovieDetailRealm.self,
                    forPrimaryKey: movie.id) else {
                        let object = self.mapper.movieDetailToRealm(movieDetail: movie)
                        realm.add(object, update: .all)
                        return
                }
                realm.delete(object)
            }
        } catch { }
    }
    
    func removeAllMovie() {
        do {
            let realm = try Realm()
            try realm.write {
                realm.delete(realm.objects(MovieDetailRealm.self))
            }
        } catch { }
    }
    
    func existOnDatabase(movieId: Int) -> Observable<Bool> {
        do {
            let realm = try Realm()
            if realm.object(ofType: MovieDetailRealm.self,
                               forPrimaryKey: movieId) != nil {
                return .just(true)
            }
        } catch { }
        return .just(false)
    }
}
