//
//  Videos.swift
//  MovieDB
//
//  Created by Bùi Xuân Huy on 11/27/19.
//  Copyright © 2019 huy. All rights reserved.
//

import ObjectMapper

struct Video {
    var key: String
}

extension Video {
    init() {
        self.init(key: "")
    }
}

extension Video: Mappable {
    init?(map: Map) {
        self.init()
    }
    
    mutating func mapping(map: Map) {
        key <- map["key"]
    }
}

struct Videos {
    var videos: [Video]
}

extension Videos {
    init() {
        self.init(videos: [])
    }
}

extension Videos: Mappable {
    init?(map: Map) {
        self.init()
    }
    
    mutating func mapping(map: Map) {
        videos <- map["results"]
    }
}
