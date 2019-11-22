//
//  Categories.swift
//  MovieDB
//
//  Created by Bùi Xuân Huy on 11/22/19.
//  Copyright © 2019 huy. All rights reserved.
//

import ObjectMapper

struct Category {
    var id: Int
    var name: String
}

extension Category {
    init() {
        self.init(id: 0, name: "")
    }
}

extension Category: Mappable {
    init?(map: Map) {
        self.init()
    }
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
    }
}
