//
//  NowPlaying.swift
//  MovieDB
//
//  Created by Bùi Xuân Huy on 11/13/19.
//  Copyright © 2019 huy. All rights reserved.
//

import ObjectMapper

struct NowPlaying {
    var id: Int
    var title: String
    var posterPath: String
    var backdropPath: String
    var releaseDate: String
}

extension NowPlaying {
    init() {
        self.init(id: 0,
                  title: "",
                  posterPath: "",
                  backdropPath: "",
                  releaseDate: "")
    }
}

extension NowPlaying: Mappable {
    init?(map: Map) {
        self.init()
    }
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        title <- map["title"]
        posterPath <- map["poster_path"]
        releaseDate <- map["release_date"]
    }
}

