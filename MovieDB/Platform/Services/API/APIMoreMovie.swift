//
//  APIMoreMovie.swift
//  MovieDB
//
//  Created by Bùi Xuân Huy on 11/28/19.
//  Copyright © 2019 huy. All rights reserved.
//

import ObjectMapper

enum MovieType {
    case popular
    case nowPlaying
    case topRated
    var url: String {
        switch self {
        case .popular:
            return API.APIUrl.popularUrl
        case .topRated:
            return API.APIUrl.topRatedUrl
        case .nowPlaying:
            return API.APIUrl.nowPlayingUrl
        }
    }
    var title: String {
        switch self {
        case .popular:
            return "POPULAR"
        case .topRated:
            return "TOP RATED"
        case .nowPlaying:
            return "NOW PLAYING"
        }
    }
}

extension API {
    func getMoreMovie(_ input: GetMoreMovieInput) -> Observable<GetMoreMovieOutput> {
        return request(input)
    }
}

extension API {
    final class GetMoreMovieInput: APIInput {
        init(type: MovieType, page: Int) {
            let param: JSONDictionary = [
                "page": page
            ]
            super.init(urlString: type.url,
                       parameters: param,
                       requestType: .get,
                       requireAccessToken: false)
        }
    }
    
    final class GetMoreMovieOutput: APIOutput {
        private(set) var moviesList: [MovieShortenDetail]?
        
        override func mapping(map: Map) {
            super.mapping(map: map)
            moviesList <- map["results"]
        }
    }
}
