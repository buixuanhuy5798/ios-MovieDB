//
//  APICategories.swift
//  MovieDB
//
//  Created by Bùi Xuân Huy on 11/22/19.
//  Copyright © 2019 huy. All rights reserved.
//

import ObjectMapper

extension API {
    func getCategories(_ input: GetCategoriesInput) -> Observable<GetCategoriesOutput> {
        return request(input)
    }
}

extension API {
    final class GetCategoriesInput: APIInput {
        init() {
            super.init(urlString: API.APIUrl.categoriesUrl,
                       parameters: nil,
                       requestType: .get,
                       requireAccessToken: false)
        }
    }
    
    final class GetCategoriesOutput: APIOutput {
        private(set) var categories: [Category]?
        
        override func mapping(map: Map) {
            super.mapping(map: map)
            categories <- map["genres"]
        }
    }
}
