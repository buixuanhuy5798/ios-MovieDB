//
//  APIUrls.swift
//  MovieDB
//
//  Created by Bùi Xuân Huy on 10/29/19.
//  Copyright © 2019 huy. All rights reserved.
//

extension API {
    struct APIUrl {
        private static let baseUrl = "https://api.themoviedb.org/3/"
        static let topRatedUrl = baseUrl + "movie/top_rated"
        static let backdropUrl = "https://image.tmdb.org/t/p/w300/"
    }
}
