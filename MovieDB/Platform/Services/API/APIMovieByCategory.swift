//
//  APIMovieByCategory.swift
//  MovieDB
//
//  Created by Bùi Xuân Huy on 11/22/19.
//  Copyright © 2019 huy. All rights reserved.
//

import ObjectMapper

extension API {
    func getMovieByCategory(_ input: GetMovieByCategoryInput) -> Observable<GetMovieByCategoryOutput> {
        return request(input)
    }
}

extension API {
    final class GetMovieByCategoryInput: APIInput {
        init(page: Int, genreId: Int) {
            let params: JSONDictionary = [
                "page": page,
                "with_genres": genreId
            ]
            super.init(urlString: APIUrl.getMovieByCategory,
                       parameters: params,
                       requestType: .get,
                       requireAccessToken: false)
        }
    }
    
    final class GetMovieByCategoryOutput: APIOutput {
        private(set) var movie: [MovieShortenDetail]?
        
        override func mapping(map: Map) {
            super.mapping(map: map)
            movie <- map["results"]
        }
    }
}
