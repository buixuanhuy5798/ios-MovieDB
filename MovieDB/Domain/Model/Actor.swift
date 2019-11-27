//
//  Actor.swift
//  MovieDB
//
//  Created by Bùi Xuân Huy on 11/25/19.
//  Copyright © 2019 huy. All rights reserved.
//

import ObjectMapper

struct Actor {
    var name: String
    var profilePath: String
    var avatarUrl: String {
        return API.APIUrl.backdropUrl + profilePath
    }
}

extension Actor {
    init() {
        self.init(name: "", profilePath: "")
    }
}

extension Actor: Mappable {
    init?(map: Map) {
        self.init()
    }
    
    mutating func mapping(map: Map) {
        name <- map["name"]
        profilePath <- map["profile_path"]
    }
}
