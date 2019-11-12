//
//  TopRated.swift
//  MovieDB
//
//  Created by Bùi Xuân Huy on 11/11/19.
//  Copyright © 2019 huy. All rights reserved.
//

import ObjectMapper

struct TopRated {
    var id: Int
    var title: String
    var backdropPath: String
}

extension TopRated {
    init() {
        self.init(id: 0, title: "", backdropPath: "")
    }
}

extension TopRated: Mappable {
    init?(map: Map) { self.init() }
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        title <- map["title"]
        backdropPath <- map["backdrop_path"]
    }
}
