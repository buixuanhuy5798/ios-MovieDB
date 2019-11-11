//
//  APITopRated.swift
//  MovieDB
//
//  Created by Bùi Xuân Huy on 11/11/19.
//  Copyright © 2019 huy. All rights reserved.
//

import ObjectMapper

extension API {
    func getTopRatedMovie(_ input: GetTopRatedMovieInput) -> Observable<GetTopRatedMovieOutput> {
        return request(input)
    }
}

extension API {
    final class GetTopRatedMovieInput: APIInput {
        init(page: Int) {
            let params: JSONDictionary = [
                "page": page
            ]
            super.init(urlString: APIUrl.topRatedUrl,
                       parameters: params,
                       requestType: .get,
                       requireAccessToken: false)
        }
    }
    
    final class GetTopRatedMovieOutput: APIOutput {
        private(set) var topRatedMovies: [TopRated]?
        
        override func mapping(map: Map) {
            super.mapping(map: map)
            topRatedMovies <- map["results"]
        }
    }
}
