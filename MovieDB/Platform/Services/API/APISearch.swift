//
//  APISearch.swift
//  MovieDB
//
//  Created by Bùi Xuân Huy on 11/27/19.
//  Copyright © 2019 huy. All rights reserved.
//

import ObjectMapper

extension API {
    func getSearchResult(_ input: APISearchInput) -> Observable<APISearchOutput> {
        return request(input)
    }
}

extension API {
    final class APISearchInput: APIInput {
        init(query: String, page: Int) {
            let params: JSONDictionary = [
                "query": query,
                "page": page
            ]
            super.init(urlString: API.APIUrl.searchUrl,
                       parameters: params,
                       requestType: .get,
                       requireAccessToken: false)
        }
    }
    
    final class APISearchOutput: APIOutput {
        private(set) var movieDetail: [MovieDetail]?
        
        override func mapping(map: Map) {
            super.mapping(map: map)
            movieDetail <- map["results"]
        }
    }
}
