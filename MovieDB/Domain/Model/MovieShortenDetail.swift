//
//  MovieShortenDetail.swift
//  MovieDB
//
//  Created by Bùi Xuân Huy on 11/28/19.
//  Copyright © 2019 huy. All rights reserved.
//

import ObjectMapper

struct MovieShortenDetail {
    var id: Int
    var title: String
    var posterPath: String
    var posterImageUrl: String {
        return API.APIUrl.backdropUrl + posterPath
    }
}

extension MovieShortenDetail {
    init() {
        self.init(id: 0,
                  title: "",
                  posterPath: "")
    }
}

extension MovieShortenDetail: Mappable {
    init?(map: Map) {
        self.init()
    }
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        title <- map["title"]
        posterPath <- map["poster_path"]
    }
}
