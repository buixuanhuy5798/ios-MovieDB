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
    var backdrop_path: String
}

extension TopRated {
    init() {
        self.init(id: 0, title: "", backdrop_path: "")
    }
}

extension TopRated: Mappable {
    init?(map: Map) { self.init() }
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        title <- map["title"]
        backdrop_path <- map["backdrop_path"]
    }
}
