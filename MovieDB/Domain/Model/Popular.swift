//
//  Popular.swift
//  MovieDB
//
//  Created by Bùi Xuân Huy on 11/25/19.
//  Copyright © 2019 huy. All rights reserved.
//

import ObjectMapper

struct Popular {
    var id: Int
    var title: String
    var posterPath: String
    var voteAverage: Float
    var urlImage: String {
        return API.APIUrl.backdropUrl + posterPath
    }
}

extension Popular {
    init() {
        self.init(id: 0,
                  title: "",
                  posterPath: "",
                  voteAverage: 0)
    }
}

extension Popular: Mappable {
    init?(map: Map) {
        self.init()
    }
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        title <- map["title"]
        posterPath <- map["poster_path"]
        voteAverage <- map["vote_average"]
    }
}
