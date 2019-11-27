//
//  APIPopular.swift
//  MovieDB
//
//  Created by Bùi Xuân Huy on 11/25/19.
//  Copyright © 2019 huy. All rights reserved.
//

import ObjectMapper

extension API {
    func getPopular(_ input: GetPopularInput) -> Observable<GetPopularOutput> {
        return request(input)
    }
}

extension API {
    final class GetPopularInput: APIInput {
        init(page: Int) {
            let param: JSONDictionary = [
                "page": page
            ]
            super.init(urlString: APIUrl.popularUrl,
                       parameters: param, requestType: .get,
                       requireAccessToken: false)
        }
    }
    
    final class GetPopularOutput: APIOutput {
        private(set) var popular: [Popular]?
        
        override func mapping(map: Map) {
            super.mapping(map: map)
            popular <- map["results"]
        }
    }
}

