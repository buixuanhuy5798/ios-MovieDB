//
//  MovieDetailRealm.swift
//  MovieDB
//
//  Created by Bùi Xuân Huy on 11/28/19.
//  Copyright © 2019 huy. All rights reserved.
//

import RealmSwift

final class MovieDetailRealm: Object {
    @objc dynamic var id = 0
    @objc dynamic var title = ""
    @objc dynamic var posterPath = ""
    @objc dynamic var timeAdd = Date()
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

final class MapperMovie {
    static let shared = MapperMovie()
    
    func movieDetailToRealm(movieDetail: MovieShortenDetail) -> MovieDetailRealm {
        let obj = MovieDetailRealm()
        obj.id = movieDetail.id
        obj.title = movieDetail.title
        obj.posterPath = movieDetail.posterPath
        obj.timeAdd = Date()
        return obj
    }
    
    func realmToMovieDetail(realmModel: MovieDetailRealm) -> MovieShortenDetail {
        return MovieShortenDetail(id: realmModel.id,
                                  title: realmModel.title,
                                  posterPath: realmModel.posterPath)
    }
    
    func movieDetailToShortenType(movieDetail: MovieDetail) -> MovieShortenDetail {
        return MovieShortenDetail(id: movieDetail.id,
                                  title: movieDetail.title,
                                  posterPath: movieDetail.posterPath)
    }
}
